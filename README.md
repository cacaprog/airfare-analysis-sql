# Project: Analyzing Airfare Data

### About dataset
Basic Information:
- year: The year of the flight data
- quarter: The quarter of the year (1-4)
- citymarketid_1 and citymarketid_2: Unique identifier codes for the origin and destination cities
- city1 and city2: Names of the origin and destination cities
- nsmiles: Distance between cities in nautical miles

Passenger and Fare Information:
- passengers: Number of passengers on this route during this period
- fare: Average fare price for this route

Largest Carrier Information:
- carrier_lg: Code for the largest carrier on this route (e.g., 'DL' for Delta)
- large_ms: Market share of the largest carrier (as a decimal, e.g., 0.63 means 63%)
- fare_lg: Average fare charged by the largest carrier

Lowest-Fare Carrier Information:
- carrier_low: Code for the carrier with the lowest fare
- lf_ms: Market share of the lowest-fare carrier
- fare_low: The lowest average fare on this route

Additional Information:
- table_1_flag: Binary indicator (1/0) - likely used for data processing
- geocoded_city1 and geocoded_city2: Geographic coordinates for origin and destination cities

### Exploration: Familiarize yourself with the dataset.

**What range of years are represented in the data?**
23 years range, from 1996 to 2018

**What are the shortest and longest-distanced flights, and between which 2 cities are they?**




        Note: When we imported the data from a CSV file, all fields are treated as a string. Make sure to convert the value field into a numeric type if you will be ordering by that field. See here for a hint.

How many distinct cities are represented in the data (regardless of whether it is the source or destination)?
        Hint: We can use UNION to help fetch data from both the city1 and city2 columns. Note the distinction between UNION and UNION ALL.


Analysis: Further explore and analyze the data.

Which airline appear most frequently as the carrier with the lowest fare (ie. carrier_low)? How about the airline with the largest market share (ie. carrier_lg)?

How many instances are there where the carrier with the largest market share is not the carrier with the lowest fare? What is the average difference in fare?
