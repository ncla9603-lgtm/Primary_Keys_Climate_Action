# Monthly Indicators of Climate Change in New York (SDG 13)

## Project Overview
This project targets UN Sustainable Development Goal 13 (Climate Action) by monitoring monthly atmospheric CO2 levels, temperature, and humidity across low, mid, and high altitudes in New York State.

## Importance
Our SDG is important for many reasons. First, since the Industrial Revolution, our greenhouse gas emissions have greatly sped up climate change. One reason why this is important is that it helps protect the essentials for human survival. This goal helps stabilize ecosystems that ultimately give us the environment to live in and thrive. Another reason it matters is that climate change shifts growing seasons and increases floods and droughts. Striving for SDG 13 will help prevent catastrophic food shortages and water scarcity that might affect poorer regions. Lastly, another reason why SDG 13 matters is that it preserves global and economic stability. Climate-related disasters cause hundreds of billions of dollars in economic losses annually through infrastructure destruction, supply chain issues, and strain on the healthcare system.

## Project Definition 
Our team will support environmental sustainability organizations in a climate monitoring initiative aimed at supporting SDG 13: Climate Action by analyzing monthly fluctuations in regional climate indicators and greenhouse gas emissions across New York State. To answer how climate indicators change from month to month, our system ingests multi-altitude environmental data gathered through three primary physical collection methods: ground-level portable air sampling monitors operated directly by field teams, UAV sampler drones capturing high-altitude atmospheric data, and fixed weather towers continuously logging greenhouse gas fluxes at a neutral baseline altitude. Together, these sources monitor greenhouse gas presence alongside fundamental weather metrics to track microclimate shifts and track economic and environmental risks tied to climate change.
Once ingested, the raw environmental metrics are structured into a standardized relational format designed for temporal and spatial comparison. The standardized data stream combines multiple data types, including integers for CO2 concentrations measured in parts per million (ppm), decimals (to one decimal place) for temperature in Fahrenheit, decimals for relative humidity and altitude, strings for the corresponding county, and month/day timestamps. A representative data record collected by a high-altitude drone on October 15th in Erie County would be ingested as: Date: "10/15", County: "Erie", Altitude_ft: 450.0, CO2_ppm: 421, Temp_F: 58.4, and Humidity: 0.68. This structured dataset allows our platform to map localized monthly trends across varying elevations, empowering policymakers to pinpoint seasonal spikes in emissions and temperature anomalies across New York.
## Research Questions
1. How do CO2 levels and temperatures fluctuate seasonally?
2. How does CO2 concentration vary across altitude gradients?
3. Is there a correlation between relative humidity and atmospheric temperature?
4. How well do UAV drone and portable monitor readings calibrate with weather towers?
5. Do regional microclimates differ across urban and rural NY counties?

## Project Definition Data 
Our team will organize the data collected from portable air monitors, drones, and weather towers into a database. The data will include CO2 levels, temperature, humidity, altitude, Our team will organize the data collected from portable air monitors, drones, and weather towers into a database. The data will have CO2 levels, temperature, humidity, altitude, location, and dates from several counties in New York State. Each row will have the information collected, and each column will show a different type of data. For example, CO2 levels will be measured in parts per million (ppm), temperature in Fahrenheit, altitude in feet, and humidity as a percentage. We will also include the dates and counties where the data was collected. This information will be organized by comparing all the data from month to month and throughout the seasons. We would like to answer three questions: How do CO2 levels and temperatures change throughout the seasons? In what ways can CO2 levels differ at different altitudes? What is the connection between temperature and humidity? This project will help us identify climate patterns in different areas of New York State and understand how the climate changes over time.

## DBMS Selection
**PostgreSQL:** Selected for its robust numerical functions, native time-series handling, strict data integrity constraints, and PostGIS compatibility for future spatial analysis.

## Relational Structure
* **Many-to-Many (M:N):** `County_Table` <-> `Device_Table` via `Device_County` junction table.
* **One-to-Many (1:N):** `Device_Table` -> `Observation_Table`.
