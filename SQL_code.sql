create database energy;
use energy;
SELECT DATABASE();

SELECT COUNT(*) AS total_rows
FROM energy_demand_cleaned_2024_2025;

SELECT *
FROM energy_demand_cleaned_2024_2025
LIMIT 10;

SELECT
    MIN(timestamp) AS start_date,
    MAX(timestamp) AS end_date
FROM energy_demand_cleaned_2024_2025;

SELECT
    MIN(timestamp) AS start_date,
    MAX(timestamp) AS end_date
FROM energy_demand_cleaned_2024_2025;

SELECT
    COUNT(*) AS total_rows,
    SUM(timestamp IS NULL) AS null_timestamp,
    SUM(consumption_mw IS NULL) AS null_consumption
FROM energy_demand_cleaned_2024_2025;

SELECT *
FROM energy_demand_cleaned_2024_2025
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    SUM(timestamp IS NULL) AS null_timestamp,
    SUM(consumption_mw IS NULL) AS null_consumption,
    SUM(generation_mw IS NULL) AS null_generation
FROM energy_demand_cleaned_2024_2025;

SELECT
    timestamp,
    COUNT(*) AS duplicate_count
FROM energy_demand_cleaned_2024_2025
GROUP BY timestamp
HAVING COUNT(*) > 1;

SELECT
    SUM(consumption_mw) AS total_consumption_mw
FROM energy_demand_cleaned_2024_2025;

SELECT
    AVG(consumption_mw) AS average_consumption_mw
FROM energy_demand_cleaned_2024_2025;


SELECT
    MAX(consumption_mw) AS maximum_consumption_mw,
    MIN(consumption_mw) AS minimum_consumption_mw
FROM energy_demand_cleaned_2024_2025;

SELECT
    SUM(consumption_mw) AS total_consumption_mw
FROM energy_demand_cleaned_2024_2025;

SELECT
    year,
    month,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw
FROM energy_demand_cleaned_2024_2025
GROUP BY year, month
ORDER BY year, month;

SELECT
    hour,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw
FROM energy_demand_cleaned_2024_2025
GROUP BY hour
ORDER BY hour;	

SELECT
    is_peak_hour,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw,
    COUNT(*) AS total_records
FROM energy_demand_cleaned_2024_2025
GROUP BY is_peak_hour
ORDER BY is_peak_hour;


SELECT
    is_weekend,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw,
    COUNT(*) AS total_records
FROM energy_demand_cleaned_2024_2025
GROUP BY is_weekend
ORDER BY is_weekend;

SELECT
    ROUND(SUM(consumption_mw), 2) AS total_consumption_mw,
    ROUND(SUM(generation_mw), 2) AS total_generation_mw,
    ROUND(SUM(generation_mw) - SUM(consumption_mw), 2) AS generation_difference_mw
FROM energy_demand_cleaned_2024_2025;


SELECT
    ROUND(SUM(import_mw), 2) AS total_import_mw,
    ROUND(SUM(export_mw), 2) AS total_export_mw
FROM energy_demand_cleaned_2024_2025;


SELECT
    ROUND(temperature, 0) AS temperature,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw,
    COUNT(*) AS total_records
FROM energy_demand_cleaned_2024_2025
GROUP BY ROUND(temperature, 0)
ORDER BY temperature;

SELECT
    hour,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw
FROM energy_demand_cleaned_2024_2025
GROUP BY hour
ORDER BY avg_consumption_mw DESC
LIMIT 1;


SELECT
    DATE(timestamp) AS consumption_date,
    ROUND(SUM(consumption_mw), 2) AS total_consumption_mw
FROM energy_demand_cleaned_2024_2025
GROUP BY DATE(timestamp)
ORDER BY total_consumption_mw DESC
LIMIT 1;

SELECT
    year,
    month,
    ROUND(AVG(consumption_mw), 2) AS avg_consumption_mw
FROM energy_demand_cleaned_2024_2025
GROUP BY year, month
ORDER BY avg_consumption_mw DESC
LIMIT 1;