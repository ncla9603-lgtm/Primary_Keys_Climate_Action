-- Accelerates JOINs between Observation_Table and Device_Table
CREATE INDEX idx_observation_device_id 
ON Observation_Table(Device_ID);

-- Accelerates JOINs on the composite junction table Device_County
CREATE INDEX idx_device_county_device_id 
ON Device_County(Device_ID);

CREATE INDEX idx_device_county_county_id 
ON Device_County(County_ID);

-- Query support Indexes 
--High frequency filtering, sorting, and analytical queries 

-- Optimizes time-series filtering and aggregations by date (e.g., monthly reports)
CREATE INDEX idx_observation_date_month 
ON Observation_Table(date_month);

-- Composite Index: Optimizes queries filtering for a specific device over a date range
-- Example: SELECT * FROM Observation_Table WHERE Device_ID = 5 AND date_month BETWEEN ...
CREATE INDEX idx_observation_device_date 
ON Observation_Table(Device_ID, date_month);

-- Composite Index: Optimizes environmental metric analysis and filtering
-- Example: Finding high CO2 readings or temperature anomalies for a specific device
CREATE INDEX idx_observation_device_co2 
ON Observation_Table(Device_ID, co2_ppm);