# Monthly Indicators of Climate Change in New York (SDG 13)

## Project Overview
This project targets UN Sustainable Development Goal 13 (Climate Action) by monitoring monthly atmospheric CO2 levels, temperature, and humidity across low, mid, and high altitudes in New York state.

## Research Questions
1. How do CO2 levels and temperatures fluctuate seasonally?
2. How does CO2 concentration vary across altitude gradients?
3. Is there a correlation between relative humidity and atmospheric temperature?
4. How well do UAV drone and portable monitor readings calibrate with weather towers?
5. Do regional microclimates differ across urban and rural NY counties?

## DBMS Selection
**PostgreSQL:** Selected for its robust numerical functions, native time-series handling, strict data integrity constraints, and PostGIS compatibility for future spatial analysis.

## Relational Structure
* **Many-to-Many (M:N):** `County_Table` <-> `Device_Table` via `Device_County` junction table.
* **One-to-Many (1:N):** `Device_Table` -> `Observation_Table`.