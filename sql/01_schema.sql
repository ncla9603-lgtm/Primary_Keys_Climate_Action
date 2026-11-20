-- Database Schema

DROP TABLE IF EXISTS counties CASCADE;
CREATE TABLE counties (
    county_id INT PRIMARY KEY,
    county_name VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS devices CASCADE;
CREATE TABLE devices (
    device_id INT PRIMARY KEY,
    device_type VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS devices_counties CASCADE;
CREATE TABLE devices_counties (
    devices INT REFERENCES devices(device_id) ON DELETE CASCADE,
    county_id INT REFERENCES counties(county_id) ON DELETE RESTRICT,
    PRIMARY KEY (device_id, county_id)
);

DROP TABLE IF EXISTS observations CASCADE;
CREATE TABLE observations (
    observation_id INT PRIMARY KEY,
    device_id INT NOT NULL REFERENCES devices(device_id) ON DELETE CASCADE,
    date_month DATE NOT NULL,
    co2_ppm INT NOT NULL,
    humidity NUMERIC(3, 2) NOT NULL,
    temperature NUMERIC(4, 1) NOT NULL,
    altitude NUMERIC(6, 1) NOT NULL
);
