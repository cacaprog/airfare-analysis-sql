# Airfare Data Analysis with SQL

This project analyzes historical airfare data across different US cities using SQL queries to uncover insights about pricing patterns, routes, and carrier competition.

## Dataset Overview

The analysis uses a comprehensive airfare dataset containing flight information from 1996 to 2018, including:

- Flight routes between US cities
- Fare information and passenger counts
- Carrier data (largest market share and lowest-fare carriers)
- Distance between cities
- Temporal information (year and quarter)

Key dataset dimensions:
- Total records: 90,021
- Time span: 23 years (1996-2018)
- Distinct cities: 163
- Quarterly data points

## Key Findings

1. **Price Range**
   - Average fare: $193.19
   - Minimum fare: $56.42
   - Maximum fare: $540.45
   - Average passenger count per route: 803

2. **Route Distances**
   - Shortest route: Los Angeles to San Diego (109 nautical miles)
   - Longest route: Miami to Seattle (2,724 nautical miles)
   - Average distance: 1,053 nautical miles
   - Median distance: 926 nautical miles

3. **Most Popular Routes** (by total passenger volume)
   - Los Angeles ↔ San Francisco: 1,738,198 passengers (avg. fare: $109.96)
   - Miami ↔ New York City: 1,225,918 passengers (avg. fare: $155.11)
   - Los Angeles ↔ New York City: 893,802 passengers (avg. fare: $325.60)

4. **Carrier Analysis**
   - In 66.5% of routes, the carrier with the largest market share wasn't the lowest-fare carrier
   - Average fare difference when carriers differ: $49.46
   - Maximum fare difference observed: $451.83 (Orlando to San Antonio route)

5. **Seasonal Patterns**
   - Q1 shows lowest average passenger numbers (750) despite similar flight frequencies
   - Average fares remain relatively stable across quarters ($190-$196)
   - Q4 shows slightly lower fare variability (standard deviation: 58.77)

## Technical Setup

### Prerequisites
- Docker
- Docker Compose
- PostgreSQL client (optional, for direct DB access)

### Setup Instructions

1. Clone this repository:
```bash
git clone https://github.com/yourusername/airfare-analysis
cd airfare-analysis
```

2. Create a `docker-compose.yml` file:
```yaml
version: '3.8'
services:
  db:
    image: postgres:14
    environment:
      POSTGRES_USER: airfare_user
      POSTGRES_PASSWORD: your_password
      POSTGRES_DB: airfare_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  postgres_data:
```

3. Start the PostgreSQL container:
```bash
docker-compose up -d
```

4. Import the data:
```bash
# If using psql client
psql -h localhost -U airfare_user -d airfare_db -f schema.sql
psql -h localhost -U airfare_user -d airfare_db -f data.sql
```

## Project Structure
```
airfare-analysis/
├── README.md
├── docker-compose.yml
├── schema.sql
├── data.sql
├── queries/
│   ├── basic_stats.sql
│   ├── carrier_analysis.sql
│   ├── route_analysis.sql
│   └── seasonal_analysis.sql
└── results/
    └── visualizations/
```

## SQL Queries

All SQL queries used in this analysis are available in the `queries/` directory. Each file contains documented queries for different aspects of the analysis:

- `basic_stats.sql`: Basic statistical analysis
- `carrier_analysis.sql`: Carrier competition analysis
- `route_analysis.sql`: Popular routes and distance analysis
- `seasonal_analysis.sql`: Seasonal patterns and trends

## Future Enhancements

1. Add time series analysis to track fare trends over the 23-year period
2. Incorporate geographical visualization of routes
3. Analyze the impact of market competition on fares
4. Study the correlation between distance and fare pricing
5. Investigate carrier market share changes over time

## Contributing

Feel free to fork this project and submit pull requests with improvements or additional analyses.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Dataset source: [airfare_data.csv](https://static-assets.codecademy.com/community/datasets_forum_projects/airfare_data.csv)
- Analysis inspiration: [Codecademy project](https://discuss.codecademy.com/t/data-science-independent-project-5-analyze-airfare-data/419949)

