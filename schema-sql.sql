-- Create the airfare table
CREATE TABLE airfare (
    id SERIAL PRIMARY KEY,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL CHECK (quarter BETWEEN 1 AND 4),
    citymarketid_1 INTEGER NOT NULL,
    citymarketid_2 INTEGER NOT NULL,
    city1 VARCHAR(100) NOT NULL,
    city2 VARCHAR(100) NOT NULL,
    nsmiles NUMERIC(10,2) NOT NULL,
    passengers INTEGER NOT NULL,
    fare NUMERIC(10,2) NOT NULL,
    carrier_lg VARCHAR(10) NOT NULL,
    large_ms NUMERIC(5,4) NOT NULL,
    fare_lg NUMERIC(10,2) NOT NULL,
    carrier_low VARCHAR(10) NOT NULL,
    lf_ms NUMERIC(5,4) NOT NULL,
    fare_low NUMERIC(10,2) NOT NULL,
    table_1_flag INTEGER NOT NULL,
    geocoded_city1 POINT,
    geocoded_city2 POINT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX idx_airfare_year_quarter ON airfare(year, quarter);
CREATE INDEX idx_airfare_cities ON airfare(city1, city2);
CREATE INDEX idx_airfare_carriers ON airfare(carrier_lg, carrier_low);
CREATE INDEX idx_airfare_fare ON airfare(fare);
CREATE INDEX idx_airfare_passengers ON airfare(passengers);

-- Create views for common analysis
CREATE VIEW v_route_statistics AS
SELECT 
    city1,
    city2,
    COUNT(*) as total_flights,
    ROUND(AVG(passengers), 2) as avg_passengers,
    ROUND(AVG(fare), 2) as avg_fare,
    ROUND(MIN(fare), 2) as min_fare,
    ROUND(MAX(fare), 2) as max_fare,
    ROUND(AVG(nsmiles), 2) as distance
FROM airfare
GROUP BY city1, city2;

CREATE VIEW v_carrier_statistics AS
SELECT 
    carrier_lg as carrier,
    COUNT(*) as total_routes,
    ROUND(AVG(large_ms * 100), 2) as avg_market_share,
    ROUND(AVG(fare_lg), 2) as avg_fare
FROM airfare
GROUP BY carrier_lg;
