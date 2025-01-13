# Project: Analyzing Airfare Data with SQL
- table: airfare
- data from csv file

## About dataset
**Basic Information:**
- year: The year of the flight data
- quarter: The quarter of the year (1-4)
- citymarketid_1 and citymarketid_2: Unique identifier codes for the origin and destination cities
- city1 and city2: Names of the origin and destination cities
- nsmiles: Distance between cities in nautical miles

**Passenger and Fare Information:**
- passengers: Number of passengers on this route during this period
- fare: Average fare price for this route

**Largest Carrier Information:**
- carrier_lg: Code for the largest carrier on this route (e.g., 'DL' for Delta)
- large_ms: Market share of the largest carrier (as a decimal, e.g., 0.63 means 63%)
- fare_lg: Average fare charged by the largest carrier

**Lowest-Fare Carrier Information:**
- carrier_low: Code for the carrier with the lowest fare
- lf_ms: Market share of the lowest-fare carrier
- fare_low: The lowest average fare on this route

**Additional Information:**
- table_1_flag: Binary indicator (1/0) 
- geocoded_city1 and geocoded_city2: Geographic coordinates for origin and destination cities

## Exploratory Data Analysis - EDA
**Total Records:** 90021

```sql
SELECT COUNT(*) as total_records 
FROM airfare;
```

**Statistics for numerical columns**

| avg_fare | min_fare |	max_fare | avg_passengers | avg_distance |
| -- | -- | -- | -- | -- |
| 193.19 | 56.42 | 540.45 | 802.53 | 1052.67 |

```SQL
SELECT
	ROUND(AVG(fare), 2) as avg_fare,
	ROUND(MIN(fare), 2) as min_fare,
	ROUND(MAX(fare), 2) as max_fare,
	ROUND(AVG(passengers), 2) as avg_passengers,
	ROUND(AVG(nsmiles), 2) as avg_distance
FROM airfare;
```

**What range of years are represented in the data?**

23 years, from 1996 to 2018

```SQL
SELECT
	MIN(year) as earliest_year,
	MAX(year) as latest_year,
	COUNT(DISTINCT year) as unique_years
FROM airfare;
```

**What are the shortest and longest-distanced flights, and between which 2 cities are they?**
- The shortest flight is from Los Angeles (CA) to San Diego (CA). It have 109 nautical miles, or 201,86 km.
- The largest flight is from Miami (FL) to Seattle (WA). It have 2724 nautical miles, or 5044,84 km.

```SQL
-- shortest flight
select
	city1,
	city2,
	nsmiles as distance,
	round(avg(fare),2) as avg_fare,
	sum(passengers) as total_passangers
from airfare
where nsmiles = (select min(nsmiles) from airfare)
group by city1, city2, nsmiles;

-- lasgest flight
select
	city1,
	city2,
	nsmiles as distance,
	round(avg(fare),2) as avg_fare,
	sum(passengers) as total_passangers
from airfare
where nsmiles = (select max(nsmiles) from airfare)
group by city1, city2, nsmiles;
```

**Distance Distribution Statistics (in nautical miles)**
- minimum distance: 109
- maximum distance: 2724
- average distance: 1052.67
- median distance: 926

```SQL
SELECT 
    MIN(nsmiles) as min_distance,
    MAX(nsmiles) as max_distance,
    CAST(AVG(nsmiles) as DECIMAL(10,2)) as avg_distance,
    CAST(PERCENTILE_CONT(0.5) 
		WITHIN GROUP (ORDER BY nsmiles) 
		as DECIMAL(10,2)) as median_distance
FROM airfare;
```

**How many distinct cities are represented in the data (regardless of whether it is the source or destination)?**

There are 163 distinct cities.

```SQL
WITH all_cities AS (
	SELECT DISTINCT city1 as city
	FROM airfare
	UNION
	SELECT DISTINCT city2 as city
	FROM airfare
)
SELECT COUNT(*) as total_distinct_cities
FROM all_cities;

-- To show all the cities
WITH all_cities AS (
	SELECT DISTINCT city1 as city
	FROM airfare
	UNION
	SELECT DISTINCT city2 as city
	FROM airfare
)
SELECT city
FROM all_cities
ORDER BY city;
```

**Which airline appear most frequently as the carrier with the lowest fare (ie. carrier_low)? How about the airline with the largest market share (ie. carrier_lg)?**

Let´s find the top 5
| carrier	| frequency	| avg_low_fare	| avg_market_share_pct |
| -- | -- | -- | -- |
| WN	| 29652	| 159.96	| 41.27 |
| DL	| 8369	| 188.09	|24.89 |
| AA	| 7313	| 200.01	| 28.07 |
| US	| 6527	| 188.11	| 32.80 |
| FL	| 5997	| 188.11	| 28.64 |

```SQL
SELECT
	carrier_low as carrier,
	COUNT(*) as frequency,
	ROUND(AVG(fare_low),2) as avg_low_fare,
	ROUND(AVG(lf_ms * 100),2) as avg_market_share_pct
FROM airfare
GROUP BY carrier_low
ORDER BY frequency DESC
LIMIT 5;
```

**How many instances are there where the carrier with the largest market share is not the carrier with the lowest fare? What is the average difference in fare?**

| carrier_comparison	| count	| avg_fare_difference	| min_fare_difference	| max_fare_difference |
| -- | -- | -- | -- | --|
| Different Carrier	| 59854	| 49.46	| 0.00	| 451.83| 
| Same Carrier	| 30167	| 0.00	| 0.00	| 0.00 |



```SQL
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
	ROUND(AVG(fare_difference),2) as avg_fare_difference,
	MIN(fare_difference) as min_fare_difference,
	MAX(fare_difference) as maX_fare_difference
FROM fare_diff
GROUP BY carrier_comparison
ORDER BY carrier_comparison;

-- top 5 biggest fare differences
SELECT
	city1,
	city2,
	carrier_lg,
	carrier_low,
	fare_lg,
	fare_low,
	(fare_lg - fare_low) as fare_difference
FROM airfare
WHERE carrier_lg != carrier_low
ORDER BY fare_lg - fare_low DESC
LIMIT 5;
```

| city1	| city2	| carrier_lg	|carrier_low	| fare_lg	| fare_low	| fare_difference |
| -- | -- | -- | -- | --| -- | -- |
| Orlando, FL	| San Antonio, TX	| FL	| CO	| 632.99	| 181.16	| 451.83 |
| Houston, TX	| San Francisco, CA (Metropolitan Area)	| UA	| NK	| 423.13	| 89.19	| 333.94 |
| Houston, TX	| San Francisco, CA (Metropolitan Area)	| UA	| NK	| 437.09	| 109.97	| 327.12 |
| Houston, TX	| San Francisco, CA (Metropolitan Area)	| UA	| NK	| 434.64	| 112.43	| 322.21 |
| Atlanta, GA (Metropolitan Area)	| Cincinnati, OH	| DL	| NW	| 428.92	| 106.87	| 322.05 |

