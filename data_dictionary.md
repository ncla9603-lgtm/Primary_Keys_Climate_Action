# Database Data Dictionary

This document serves as the official data dictionary for the system's database schema, outlining all tables, columns, data types, constraints, and relationships for the Primary Keys Group.

---

## Entity Relationship Summary

* **`County_Table`**: Stores geographic county entities.
* **`Device_Table`**: Stores hardware monitoring device records.
* **`Device_County`**: Junction table representing the many-to-many assignment between devices and counties.
* **`Observation_Table`**: Stores time-series environmental measurements recorded by assigned devices.

---

## Detailed Schema Definitions

### 1. `County_Table`

**Description:** Primary lookup table for geographic counties monitored by the system.

| Column Name | Data Type | Nullable? | Key / Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `County_ID` | `INT` | No | Primary Key | Unique integer identifier for each county record. |
| `County_Name` | `VARCHAR(50)` | No | Unique | Official name of the county (must be unique across all records). |

---

### 2. `Device_Table`

**Description:** Contains metadata for physical monitoring hardware units.

| Column Name | Data Type | Nullable? | Key / Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `Device_ID` | `INT` | No | Primary Key | Unique integer identifier for each hardware device. |
| `Device_Type` | `VARCHAR(50)` | No | None | Categorization or model type of the monitoring unit (e.g., Air Quality Sensor, Weather Station). |

---

### 3. `Device_County`

**Description:** Mapping/junction table defining which devices operate in which counties. Supports a many-to-many relationship.

| Column Name | Data Type | Nullable? | Key / Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `Device_ID` | `INT` | No | Composite PK, Foreign Key (`Device_Table.Device_ID`) | References the unique device. `ON DELETE CASCADE` removes mapping if device record is deleted. |
| `County_ID` | `INT` | No | Composite PK, Foreign Key (`County_Table.County_ID`) | References the unique county. `ON DELETE RESTRICT` prevents county deletion if linked to a device. |

---

### 4. `Observation_Table`

**Description:** Contains environmental sensor readings collected by deployed devices.

| Column Name | Data Type | Nullable? | Key / Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `Observation_ID` | `INT` | No | Primary Key | Unique identifier for an individual observation log. |
| `Device_ID` | `INT` | No | Foreign Key (`Device_Table.Device_ID`) | Identifies the physical device that logged the measurement. `ON DELETE CASCADE` clears observations if device is removed. |
| `date_month` | `DATE` | No | None | Timestamp or date associated with the logged measurement. |
| `co2_ppm` | `INT` | No | None | Carbon dioxide concentration reading measured in parts per million (PPM). |
| `humidity` | `NUMERIC(3, 2)` | No | None | Relative humidity value formatted as a decimal ratio (max value: `9.99`, typical range `0.00` to `1.00`). |
| `Temperature` | `NUMERIC(4, 1)` | No | None | Ambient temperature measurement (up to 4 digits total, 1 decimal place, e.g., `102.5` or `-12.4`). |
| `Altitude` | `NUMERIC(6, 1)` | No | None | Elevation measurement above sea level (up to 6 digits total, 1 decimal place, e.g., `14150.5`). |