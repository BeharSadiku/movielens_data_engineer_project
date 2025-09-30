# DBT Project - MovieLens 32M (Updated)

This folder contains the **DBT project** responsible for transforming the Bronze layer into **Silver** and **Gold** layers.  
It connects to Databricks to pull Bronze tables (now in Unity Catalog) and performs transformations for analytics and BI use cases.

---

## Folder Structure

dbt/
├── models/
│ ├── silver/
│ │ ├── silver_ratings.sql
│ │ ├── silver_movies.sql
│ │ ├── silver_tags.sql
│ │ └── silver_links.sql
│ └── gold/
│ ├── gold_movie_ratings.sql
│ ├── gold_top_movies.sql
│ ├── gold_movie_performance.sql
│ └── gold_genre_popularity.sql
├── dbt_project.yml
├── profiles.yml.example
└── sources.yml # References Bronze tables

---

## Prerequisites

- DBT installed (`pip install dbt-databricks` recommended)  
- Python 3.x  
- Databricks workspace with **Bronze tables already created in Unity Catalog**  
- Network access to Databricks from your local machine (or DBT Studio)  

---

## Step 1: Configure Profiles

1. Copy `profiles.yml.example` to `profiles.yml`.  
2. Update the `dev` target with your Databricks connection details.  

Example for **Unity Catalog**:

```yaml
my_dbt_project:
  target: dev
  outputs:
    dev:
      type: databricks
      catalog: workspace         # Unity Catalog
      schema: movielens_volume   # Schema containing Bronze tables
      host: <your-databricks-host>
      http_path: <your-sql-warehouse-http-path>
      token: <your-databricks-token>
      threads: 1

Step 2: Define Sources

Create sources.yml to reference your Bronze tables:
version: 2

sources:
  - name: bronze
    database: workspace          # Unity Catalog
    schema: movielens_volume     # Schema containing Bronze tables
    tables:
      - name: bronze_ratings
      - name: bronze_movies
      - name: bronze_tags
      - name: bronze_links

Step 3: Run Transformations

Navigate to the dbt/ folder.

Incremental / Full-Refresh

Some models are incremental for efficiency (e.g., gold_movie_performance.sql).

Incremental run: dbt run
Full-refresh run: dbt run --full-refresh

Silver models: Cleansed and enriched tables.
Gold models: Analytics-ready tables, suitable for dashboards or BI tools.

Rounding and Cleaning
Numeric metrics in Gold models are rounded to 2 decimals (ratings, standard deviation, influence score).
Timestamps are truncated to dates for consistency.
Run Order / Dependencies
Silver tables must run first.
Gold tables depend on Silver tables.

Step 4: Test & Validate

Run built-in DBT tests: dbt test

Tests include:
unique
not_null

Optional: Add custom tests for business logic validation (e.g., ratings range, influence score computation).

