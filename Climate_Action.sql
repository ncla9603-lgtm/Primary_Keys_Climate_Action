-- Database Schema

DROP TABLE IF EXISTS County_Table CASCADE;
CREATE TABLE County_Table (
    County_ID INT PRIMARY KEY,
    County_Name VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Device_Table CASCADE;
CREATE TABLE Device_Table (
    Device_ID INT PRIMARY KEY,
    Device_Type VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Device_County CASCADE;
CREATE TABLE Device_County (
    Device_ID INT REFERENCES Device_Table(Device_ID) ON DELETE CASCADE,
    County_ID INT REFERENCES County_Table(County_ID) ON DELETE RESTRICT,
    PRIMARY KEY (Device_ID, County_ID)
);

DROP TABLE IF EXISTS Observation_Table CASCADE;
CREATE TABLE Observation_Table (
    Observation_ID INT PRIMARY KEY,
    Device_ID INT NOT NULL REFERENCES Device_Table(Device_ID) ON DELETE CASCADE,
    date_month DATE NOT NULL,
    co2_ppm INT NOT NULL,
    humidity NUMERIC(3, 2) NOT NULL,
    Temperature NUMERIC(4, 1) NOT NULL,
    Altitude NUMERIC(6, 1) NOT NULL
);
--Indexs 
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