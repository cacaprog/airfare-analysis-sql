-- Carrier market share analysis
SELECT
    carrier_lg as carrier,
    COUNT(*) as frequency,
    ROUND(AVG(fare_lg), 2) as avg_fare,
    ROUND(AVG(large_ms * 100), 2) as avg_market_share_pct,
    COUNT(DISTINCT year) as years_active
FROM airfare
GROUP BY carrier_lg
ORDER BY frequency DESC;

-- Lowest fare carrier analysis
SELECT
    carrier_low as carrier,
    COUNT(*) as frequency,
    ROUND(AVG(fare_low), 2) as avg_low_fare,
    ROUND(AVG(lf_ms * 100), 2) as avg_market_share_pct
FROM airfare
GROUP BY carrier_low
ORDER BY frequency DESC;

-- Carrier competition analysis
WITH fare_diff AS (
    SELECT
        CASE
            WHEN carrier_lg = carrier_low THEN 'Same Carrier'
            ELSE 'Different Carrier'
        END as carrier_comparison,
        fare_lg - fare_low as fare_difference
    FROM airfare
)
SELECT 
    carrier_comparison,
    COUNT(*) as count,
    ROUND(AVG(fare_difference), 2) as avg_fare_difference,
    ROUND(MIN(fare_difference), 2) as min_fare_difference,
    ROUND(MAX(fare_difference), 2) as max_fare_difference
FROM fare_diff
GROUP BY carrier_comparison
ORDER BY carrier_comparison;

-- Top fare differences between carriers
SELECT
    city1,
    city2,
    carrier_lg,
    carrier_low,
    ROUND(fare_lg, 2) as largest_carrier_fare,
    ROUND(fare_low, 2) as lowest_carrier_fare,
    ROUND(fare_lg - fare_low, 2) as fare_difference
FROM airfare
WHERE carrier_lg != carrier_low
ORDER BY (fare_lg - fare_low) DESC
LIMIT 10;

-- Market concentration analysis
SELECT
    year,
    COUNT(DISTINCT carrier_lg) as num_largest_carriers,
    COUNT(DISTINCT carrier_low) as num_lowest_fare_carriers,
    ROUND(AVG(large_ms * 100), 2) as avg_market_share_pct
FROM airfare
GROUP BY year
ORDER BY year;
