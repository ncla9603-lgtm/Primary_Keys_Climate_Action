# Monthly Indicators of Climate Change in New York (SDG 13)

## Project Overview
This project targets UN Sustainable Development Goal 13 (Climate Action) by monitoring monthly atmospheric CO2 levels, temperature, and humidity across low, mid, and high altitudes in New York State.

## Importance
Our SDG is important for many reasons. First, since the Industrial Revolution, our greenhouse gas emissions have greatly sped up climate change. One reason why this is important is that it helps protect the essentials for human survival. This goal helps stabilize ecosystems that ultimately give us the environment to live in and thrive. Another reason it matters is that climate change shifts growing seasons and increases floods and droughts. Striving for SDG 13 will help prevent catastrophic food shortages and water scarcity that might affect poorer regions. Lastly, another reason why SDG 13 matters is that it preserves global and economic stability. Climate-related disasters cause hundreds of billions of dollars in economic losses annually through infrastructure destruction, supply chain issues, and strain on the healthcare system.

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
