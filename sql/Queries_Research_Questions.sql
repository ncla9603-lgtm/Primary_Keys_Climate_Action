--Query 1.1 How do CO2 levels and temperatures fluctuate seasonally 

SELECT 
    EXTRACT(MONTH FROM date_month) AS month_number,
    TO_CHAR(date_month, 'Month') AS month_name,
    ROUND(AVG(co2_ppm), 2) AS avg_co2_ppm,
    ROUND(AVG(Temperature), 2) AS avg_temperature,
    MIN(co2_ppm) AS min_co2_ppm,
    MAX(co2_ppm) AS max_co2_ppm,
    MIN(Temperature) AS min_temperature,
    MAX(Temperature) AS max_temperature
FROM Observation_Table
GROUP BY EXTRACT(MONTH FROM date_month), TO_CHAR(date_month, 'Month')
ORDER BY month_number;

-- Query 1.2 Aggregate by season

SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM date_month) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM date_month) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM date_month) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Autumn'
    END AS season,
    ROUND(AVG(co2_ppm), 2) AS avg_co2_ppm,
    ROUND(AVG(Temperature), 2) AS avg_temperature,
    COUNT(Observation_ID) AS total_observations
FROM Observation_Table
GROUP BY season
ORDER BY avg_temperature DESC;

--2.1 Query CO2 metrics separated by altitude brackets

SELECT 
    CASE 
        WHEN Altitude < 500 THEN 'Low Altitude (< 500m)'
        WHEN Altitude BETWEEN 500 AND 1500 THEN 'Mid Altitude (500m - 1500m)'
        ELSE 'High Altitude (> 1500m)'
    END AS altitude_tier,
    COUNT(Observation_ID) AS sample_count,
    ROUND(AVG(co2_ppm), 2) AS avg_co2_ppm,
    ROUND(STDDEV(co2_ppm), 2) AS stddev_co2_ppm,
    MIN(co2_ppm) AS min_co2,
    MAX(co2_ppm) AS max_co2
FROM Observation_Table
GROUP BY altitude_tier
ORDER BY MIN(Altitude);

--Query 2.2 Device Specific vertical analysis 

SELECT 
    d.Device_Type,
    ROUND(AVG(o.Altitude), 1) AS avg_sampling_altitude,
    ROUND(AVG(o.co2_ppm), 2) AS avg_co2_ppm,
    CORR(o.Altitude, o.co2_ppm) AS altitude_co2_correlation
FROM Observation_Table o
JOIN Device_Table d ON o.Device_ID = d.Device_ID
GROUP BY d.Device_Type;

-- Query 3.1 Pearson Correlation and Covariance 

SELECT 
    COUNT(*) AS total_readings,
    ROUND(CAST(CORR(humidity, Temperature) AS numeric), 4) AS pearson_correlation_r,
    ROUND(CAST(COVAR_SAMP(humidity, Temperature) AS numeric), 4) AS sample_covariance,
    ROUND(AVG(humidity), 4) AS avg_humidity,
    ROUND(AVG(Temperature), 2) AS avg_temperature
FROM Observation_Table;

--Query 3.2 Humidity Distribution across temperature ranges 

SELECT 
    CASE 
        WHEN Temperature < 32.0 THEN 'Freezing (< 32F)'
        WHEN Temperature BETWEEN 32.0 AND 65.0 THEN 'Cool/Moderate (32F - 65F)'
        WHEN Temperature BETWEEN 65.1 AND 85.0 THEN 'Warm (65F - 85F)'
        ELSE 'Hot (> 85F)'
    END AS temp_bracket,
    ROUND(AVG(humidity), 4) AS avg_relative_humidity,
    ROUND(MIN(humidity), 4) AS min_relative_humidity,
    ROUND(MAX(humidity), 4) AS max_relative_humidity
FROM Observation_Table
GROUP BY temp_bracket
ORDER BY MIN(Temperature);

--Query 4.1 Device measurement variance comparison

SELECT 
    d.Device_Type,
    COUNT(o.Observation_ID) AS total_logs,
    ROUND(AVG(o.co2_ppm), 2) AS avg_co2,
    ROUND(STDDEV(o.co2_ppm), 2) AS stddev_co2,
    ROUND(AVG(o.Temperature), 2) AS avg_temp,
    ROUND(STDDEV(o.Temperature), 2) AS stddev_temp,
    ROUND(AVG(o.humidity), 4) AS avg_humidity
FROM Observation_Table o
JOIN Device_Table d ON o.Device_ID = d.Device_ID
GROUP BY d.Device_Type;

--Query 4.2 Located County reading analysis 

SELECT 
    c.County_Name,
    o.date_month,
    ROUND(AVG(CASE WHEN d.Device_Type = 'Weather Tower' THEN o.co2_ppm END), 2) AS tower_co2_avg,
    ROUND(AVG(CASE WHEN d.Device_Type = 'UAV Drone' THEN o.co2_ppm END), 2) AS drone_co2_avg,
    ROUND(AVG(CASE WHEN d.Device_Type = 'Handheld Monitor' THEN o.co2_ppm END), 2) AS handheld_co2_avg,
    ROUND(
        ABS(
            AVG(CASE WHEN d.Device_Type = 'Weather Tower' THEN o.co2_ppm END) - 
            AVG(CASE WHEN d.Device_Type = 'UAV Drone' THEN o.co2_ppm END)
        ), 2
    ) AS tower_drone_delta_ppm
FROM Observation_Table o
JOIN Device_Table d ON o.Device_ID = d.Device_ID
JOIN Device_County dc ON d.Device_ID = dc.Device_ID
JOIN County_Table c ON dc.County_ID = c.County_ID
GROUP BY c.County_Name, o.date_month
HAVING COUNT(DISTINCT d.Device_Type) > 1
ORDER BY c.County_Name, o.date_month;

--Query 5.1 Regional environmental metrics by county 

SELECT 
    c.County_Name,
    COUNT(DISTINCT dc.Device_ID) AS active_devices,
    COUNT(o.Observation_ID) AS total_readings,
    ROUND(AVG(o.Temperature), 2) AS avg_county_temp,
    ROUND(AVG(o.co2_ppm), 2) AS avg_county_co2,
    ROUND(AVG(o.humidity), 4) AS avg_county_humidity
FROM County_Table c
JOIN Device_County dc ON c.County_ID = dc.County_ID
JOIN Observation_Table o ON dc.Device_ID = o.Device_ID
GROUP BY c.County_ID, c.County_Name
ORDER BY avg_county_temp DESC;

--Query 5.2 Microclimate Extremes and Thermal Spans across Counties

SELECT 
    c.County_Name,
    MAX(o.Temperature) - MIN(o.Temperature) AS temp_range_span,
    ROUND(VARIANCE(o.Temperature), 2) AS temp_variance,
    ROUND(AVG(o.co2_ppm), 2) AS avg_co2_ppm,
    MAX(o.co2_ppm) AS peak_co2_spike
FROM County_Table c
JOIN Device_County dc ON c.County_ID = dc.County_ID
JOIN Observation_Table o ON dc.Device_ID = o.Device_ID
GROUP BY c.County_ID, c.County_Name
ORDER BY temp_range_span DESC;