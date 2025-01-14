-- Quarterly analysis
SELECT
    quarter,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(AVG(passengers), 0) as avg_passengers,
    COUNT(*) as number_of_flights,
    ROUND(STDDEV(fare), 2) as fare_stddev
FROM airfare
GROUP BY quarter
ORDER BY quarter;

-- Yearly and quarterly analysis
SELECT
    year,
    quarter,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(AVG(passengers), 0) as avg_passengers,
    COUNT(*) as number_of_flights
FROM airfare
GROUP BY year, quarter
ORDER BY year, quarter;

-- Seasonal fare variations by distance category
WITH route_categories AS (
    SELECT *,
        CASE 
            WHEN nsmiles < 500 THEN 'Short'
            WHEN nsmiles < 1000 THEN 'Medium'
            ELSE 'Long'
        END as distance_category
    FROM airfare
)
SELECT
    distance_category,
    quarter,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(AVG(passengers), 0) as avg_passengers,
    COUNT(*) as number_of_flights
FROM route_categories
GROUP BY distance_category, quarter
ORDER BY distance_category, quarter;

-- Peak season analysis by route
SELECT
    city1,
    city2,
    quarter,
    ROUND(AVG(passengers), 0) as avg_passengers,
    ROUND(AVG(fare), 2) as avg_fare,
    COUNT(*) as number_of_flights
FROM airfare
GROUP BY city1, city2, quarter
HAVING COUNT(*) >= 20  -- Only routes with sufficient data
ORDER BY avg_passengers DESC
LIMIT 20;

-- Year-over-year growth analysis
WITH yearly_stats AS (
    SELECT
        year,
        ROUND(AVG(fare), 2) as avg_fare,
        SUM(passengers) as total_passengers
    FROM airfare
    GROUP BY year
)
SELECT
    year,
    avg_fare,
    total_passengers,
    ROUND(((avg_fare - LAG(avg_fare) OVER (ORDER BY year)) / LAG(avg_fare) OVER (ORDER BY year) * 100), 2) as fare_growth_pct,
    ROUND(((total_passengers - LAG(total_passengers) OVER (ORDER BY year)) / LAG(total_passengers) OVER (ORDER BY year) * 100), 2) as passenger_growth_pct
FROM yearly_stats
ORDER BY year;
