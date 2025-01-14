-- Basic dataset statistics
SELECT COUNT(*) as total_records FROM airfare;

-- Fare statistics
SELECT
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(MIN(fare), 2) as min_fare,
    ROUND(MAX(fare), 2) as max_fare,
    ROUND(STDDEV(fare), 2) as stddev_fare,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY fare), 2) as median_fare
FROM airfare;

-- Distance statistics
SELECT 
    ROUND(MIN(nsmiles), 2) as min_distance,
    ROUND(MAX(nsmiles), 2) as max_distance,
    ROUND(AVG(nsmiles), 2) as avg_distance,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY nsmiles), 2) as median_distance,
    ROUND(STDDEV(nsmiles), 2) as stddev_distance
FROM airfare;

-- Year range
SELECT
    MIN(year) as earliest_year,
    MAX(year) as latest_year,
    COUNT(DISTINCT year) as unique_years
FROM airfare;

-- Distinct cities count
WITH all_cities AS (
    SELECT DISTINCT city1 as city FROM airfare
    UNION
    SELECT DISTINCT city2 as city FROM airfare
)
SELECT COUNT(*) as total_distinct_cities
FROM all_cities;

-- Basic passenger statistics
SELECT
    ROUND(AVG(passengers), 2) as avg_passengers,
    ROUND(MIN(passengers), 2) as min_passengers,
    ROUND(MAX(passengers), 2) as max_passengers,
    ROUND(STDDEV(passengers), 2) as stddev_passengers
FROM airfare;
