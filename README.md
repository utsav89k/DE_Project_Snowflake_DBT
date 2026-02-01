# Airbnb Data Engineering Project (Snowflake + dbt)

## Overview

This project implements an end-to-end data engineering pipeline for
Airbnb datasets using Snowflake and dbt, following the Medallion
Architecture (Bronze → Silver → Gold). Raw data is ingested from AWS S3,
cleaned and standardized in dbt, and transformed into analytics-ready
models for downstream use.

## Pipeline Architecture

Data Flow: AWS S3 → Snowflake Staging → Bronze Layer → Silver Layer →
Gold Layer → Analytics

Technologies: - Snowflake (Data warehouse) - dbt Core (Transformations,
tests, snapshots) - AWS S3 (Raw data storage) - Python (Environment
setup) - SQL + Jinja

## Data Layers

### Bronze Layer (Raw)

- bronze_bookings
- bronze_hosts
- bronze_listings

### Silver Layer (Clean)

- silver_bookings
- silver_hosts
- silver_listings

### Gold Layer (Analytics)

- gold_fact
- gold_obt

### Snapshots (SCD Type-2)

- dim_hosts
- dim_listings
- dim_bookings

## Key Features

- Incremental dbt models for efficient processing
- Custom macros and Dynamic SQL generation
- SCD Type-2 snapshots for historical tracking
- Ephemeral models for optimized transformations
- Data quality testing (unique, not-null, relationships)
- Automatic lineage documentation via dbt

## 📁 Project Structure

```
AWS_DBT_Snowflake/
├── README.md                           # This file
├── pyproject.toml                      # Python dependencies
├── main.py                             # Main execution script
│
├── SourceData/                         # Raw CSV data files
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── DDL/                                # Database schema definitions
│   ├── snowquery_ddl.sql                         # Table creation scripts
│   └── resources.sql
│
└── aws_dbt_snowflake_project/         # Main dbt project
    ├── dbt_project.yml                 # dbt project configuration
    ├── ExampleProfiles.yml             # Snowflake connection profile
    │
    ├── models/                         # dbt models
    │   ├── sources/
    │   │   └── sources.yml             # Source definitions
    │   ├── bronze/                     # Raw data layer
    │   │   ├── bronze_bookings.sql
    │   │   ├── bronze_hosts.sql
    │   │   └── bronze_listings.sql
    │   ├── silver/                     # Cleaned data layer
    │   │   ├── silver_bookings.sql
    │   │   ├── silver_hosts.sql
    │   │   └── silver_listings.sql
    │   └── gold/                       # Analytics layer
    │       ├── gold_fact.sql
    │       ├── gold_obt.sql
    │       └── ephemeral/              # Temporary models
    │           ├── bookings.sql
    │           ├── hosts.sql
    │           └── listings.sql
    │
    ├── macros/                         # Reusable SQL functions
    │   ├── generate_schema_name.sql    # Custom schema naming
    │   ├── multiply.sql                # Math operations
    │   ├── tag.sql                     # Categorization logic
    │   └── trimmer.sql                 # String utilities
    │
    ├── analyses/                       # Ad-hoc analysis queries
    │   ├── explore.sql
    │   ├── if_else.sql
    │   └── loop.sql
    │
    ├── snapshots/                      # SCD Type 2 configurations
    │   ├── dim_bookings.yml
    │   ├── dim_hosts.yml
    │   └── dim_listings.yml
    │
    ├── tests/                          # Data quality tests
    │   └── testing_source.sql
    │
    └── seeds/                          # Static reference data
```

### Installation

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd AWS_DBT_Snowflake
   ```

2. **Create Virtual Environment**
   ```bash
   python -m venv .venv
   .venv\Scripts\Activate.ps1  # Windows PowerShell
   # or
   source .venv/bin/activate    # Linux/Mac
   ```

3. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   # or using pyproject.toml
   pip install -e .
   ```

   **Core Dependencies:**
   - `dbt-core>=1.11.2`
   - `dbt-snowflake>=1.11.0`
   - `sqlfmt>=0.0.3`

4. **Configure Snowflake Connection**
   
   Create `~/.dbt/profiles.yml`:
   ```yaml
   aws_dbt_snowflake_project:
     outputs:
       dev:
         account: <your-account-identifier>
         database: AIRBNB
         password: <your-password>
         role: ACCOUNTADMIN
         schema: dbt_schema
         threads: 4
         type: snowflake
         user: <your-username>
         warehouse: COMPUTE_WH
     target: dev
   ```

5. **Set Up Snowflake Database**
   
   Run the DDL scripts to create tables:
   ```bash
   # Execute DDL/ddl.sql in Snowflake to create staging tables
   ```

6. **Load Source Data**
   
   Load CSV files from `SourceData/` to Snowflake staging schema:
   - `bookings.csv` → `AIRBNB.STAGING.BOOKINGS`
   - `hosts.csv` → `AIRBNB.STAGING.HOSTS`
   - `listings.csv` → `AIRBNB.STAGING.LISTINGS`

## Business Use Cases

- Host performance analytics
- Listing & pricing intelligence
- Occupancy and seasonal trend analysis
- Customer booking behaviour analysis

## Future Improvements

- Add orchestration with Airflow or Prefect
- Add CI/CD pipeline for dbt
- Integrate Great Expectations for DQ
- Build BI dashboards (Tableau / Power BI)

## Author

Utsav D Kanani

