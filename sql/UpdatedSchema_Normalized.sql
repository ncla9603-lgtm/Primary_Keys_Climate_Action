-- Updated Schema (Fully Normalized)
CREATE TABLE counties (
    County_ID INT PRIMARY KEY,
    County_Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d (
    Device_Type_ID INT PRIMARY KEY,
    Device_Type_Name VARCHAR(50) NOT NULL UNIQUE -- 'Handheld Air Monitor', 'UAV Drone', 'Weather Tower'
);

CREATE TABLE devices(
    Device_ID INT PRIMARY KEY,
    Device_Type_ID INT NOT NULL REFERENCES Device_Type_Table(Device_Type_ID),
    Fixed_Altitude NUMERIC(6, 1) NULL -- Set for Weather Towers; NULL for mobile units (Drones/Handhelds)
);

CREATE TABLE devices_counties (
    Device_ID INT REFERENCES Device_Table(Device_ID) ON DELETE CASCADE,
    County_ID INT REFERENCES County_Table(County_ID) ON DELETE RESTRICT,
    Assigned_Date DATE NOT NULL,
    PRIMARY KEY (Device_ID, County_ID, Assigned_Date)
);

CREATE TABLE observations (
    Observation_ID INT PRIMARY KEY,
    Device_ID INT NOT NULL REFERENCES Device_Table(Device_ID) ON DELETE CASCADE,
    County_ID INT NOT NULL REFERENCES County_Table(County_ID),
    Observation_Timestamp TIMESTAMP NOT NULL,
    co2_ppm INT NOT NULL,
    humidity NUMERIC(3, 2) NOT NULL,
    Temperature NUMERIC(4, 1) NOT NULL,
    Observed_Altitude NUMERIC(6, 1) NULL -- Captured per reading for Drones/Handhelds
);
CREATE TABLE Operator (
    Operator_ID INT PRIMARY KEY,
    Operator_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Device_Operator (
    Device_ID INT,
    Operator_ID INT,
    PRIMARY KEY (Device_ID, Operator_ID),
    FOREIGN KEY (Device_ID) REFERENCES Device_Table(Device_ID),
    FOREIGN KEY (Operator_ID) REFERENCES Operator(Operator_ID)
);