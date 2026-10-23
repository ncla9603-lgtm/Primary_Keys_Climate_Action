-- Database Schema
DROP TABLE IF EXISTS Observation_Table CASCADE;
DROP TABLE IF EXISTS Device_County CASCADE;
DROP TABLE IF EXISTS Device_Table CASCADE;
DROP TABLE IF EXISTS County_Table CASCADE;

CREATE TABLE County_Table (
    County_ID INT PRIMARY KEY,
    County_Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Device_Table (
    Device_ID INT PRIMARY KEY,
    Device_Type VARCHAR(50) NOT NULL
);

CREATE TABLE Device_County (
    Device_ID INT REFERENCES Device_Table(Device_ID) ON DELETE CASCADE,
    County_ID INT REFERENCES County_Table(County_ID) ON DELETE RESTRICT,
    PRIMARY KEY (Device_ID, County_ID)
);

CREATE TABLE Observation_Table (
    Observation_ID INT PRIMARY KEY,
    Device_ID INT NOT NULL REFERENCES Device_Table(Device_ID) ON DELETE CASCADE,
    date_month DATE NOT NULL,
    co2_ppm INT NOT NULL,
    humidity NUMERIC(3, 2) NOT NULL,
    Temperature NUMERIC(4, 1) NOT NULL,
    Altitude NUMERIC(6, 1) NOT NULL
);