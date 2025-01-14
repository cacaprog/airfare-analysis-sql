-- Most popular routes by passenger volume
SELECT
    city1,
    city2,
    SUM(passengers) as total_passengers,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(AVG(nsmiles), 2) as distance,
    COUNT(*) as frequency
FROM airfare
GROUP BY city1, city2
ORDER BY total_passengers DESC
LIMIT 20;

-- Shortest routes
SELECT
    city1,
    city2,
    nsmiles as distance,
    ROUND(AVG(fare), 2) as avg_fare,
    SUM(passengers) as total_passengers
FROM airfare
GROUP BY city1, city2, nsmiles
ORDER BY nsmiles
LIMIT 10;

-- Longest routes
SELECT
    city1,
    city2,
    nsmiles as distance,
    ROUND(AVG(fare), 2) as avg_fare,
    SUM(passengers) as total_passengers
FROM airfare
GROUP BY city1, city2, nsmiles
ORDER BY nsmiles DESC
LIMIT 10;

-- Route pricing analysis
SELECT
    city1,
    city2,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(MIN(fare), 2) as min_fare,
    ROUND(MAX(fare), 2) as max_fare,
    ROUND(STDDEV(fare), 2) as fare_stddev,
    ROUND(AVG(nsmiles), 2) as distance,
    COUNT(*) as observations
FROM airfare
GROUP BY city1, city2
HAVING COUNT(*) >= 20  -- Only routes with sufficient data points
ORDER BY STDDEV(fare) DESC
LIMIT 20;

-- Price per mile analysis
SELECT
    city1,
    city2,
    ROUND(AVG(fare/nsmiles), 4) as avg_price_per_mile,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(AVG(nsmiles), 2) as distance,
    SUM(passengers) as total_passengers
FROM airfare
GROUP BY city1, city2
HAVING AVG(nsmiles) >= 100  -- Exclude very short routes
ORDER BY avg_price_per_mile DESC
LIMIT 20;
