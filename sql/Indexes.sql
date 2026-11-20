-- Accelerates JOINs between Observation_Table and Device_Table
CREATE INDEX idx_observations_device_id 
ON observations(device_id);

-- Accelerates JOINs on the composite junction table Device_County
CREATE INDEX idx_devices_counties_device_id 
ON devices_counties(device_id);

CREATE INDEX idx_devices_counties_county_id 
ON devices_counties(county_id);

-- Query support Indexes 
--High frequency filtering, sorting, and analytical queries 

-- Optimizes time-series filtering and aggregations by date (e.g., monthly reports)
CREATE INDEX idx_observations_date_month 
ON observations(date_month);

-- Composite Index: Optimizes queries filtering for a specific device over a date range
-- Example: SELECT * FROM Observation_Table WHERE Device_ID = 5 AND date_month BETWEEN ...
CREATE INDEX idx_observations_device_date 
ON observations(device_id, date_month);

-- Composite Index: Optimizes environmental metric analysis and filtering
-- Example: Finding high CO2 readings or temperature anomalies for a specific device
CREATE INDEX idx_observations_device_co2 
ON observations(device_id, co2_ppm);
