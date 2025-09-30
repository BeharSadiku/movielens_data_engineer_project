# End-to-End Data Engineering Project - MovieLens 32M

This repository demonstrates an end-to-end data engineering workflow using **PySpark**, **Databricks**, and **DBT**.  
It includes ingestion, transformation, and organization into **Bronze**, **Silver**, and **Gold** layers.

---

## Folder Structure

end_to_end_de_project/
│
├── .vscode/ # VS Code settings
├── dags/ # Airflow DAGs
├── databricks/ # Databricks scripts
├── databricks_config/ # Configuration for Databricks
├── dbt/ # dbt project
├── plugins/ # Airflow plugins
├── docker-compose.yaml # Docker Compose configuration
├── Dockerfile # Docker image definition
├── README.md # Project documentation
└── requirements.txt # Python dependencies

---

## Prerequisites

- Python 3.x and pip  
- PySpark installed (for local execution)  
- Databricks Free Edition workspace (Unity Catalog optional; local schemas supported)  
- Airflow installed and configured  
- Internet connection if using automatic dataset download  

---

## Step 1: Get the Data

### Option 1: Automatic download (recommended)

Navigate to `data_download/` and run:

```bash```
python download_movielens.py
This will download the MovieLens 32M dataset and extract the required CSVs into raw_data/.

Option 2: Manual download

Download ml-32m.zip from MovieLens 32M
Extract the following CSV files into raw_data/:

ratings.csv
movies.csv
tags.csv
links.csv

Note: raw_data/ must contain all four CSV files before running any ingestion scripts.

Option 2: Local PySpark
Open a terminal in the project root folder.

Run the script: python databricks/ingest_bronze_local.py
Bronze Delta tables will be created locally in the folder: databricks/bronze/
Example local tables: bronze_ratings/, bronze_movies/, bronze_tags/, bronze_links/

Step 3: Silver and Gold Layers (DBT)
Option 1: Configure DBT

Navigate to the dbt/ folder.
Copy profiles.yml.example → profiles.yml.
Update your Databricks connection details (Unity Catalog / movielens_volume schema).

Option 2: Run DBT

Transform Bronze tables into Silver and Gold layers:dbt run

Examples:

Silver table: silver_ratings (rating scores normalized, user/movie IDs standardized)
Gold tables: movie_enriched (aggregated movie-level data with ratings, genres, and external links)
Gold tables: movie_performance (metrics like weighted average rating, polarization, top rating percentage)
Gold tables: user_activity (user-level activity and top genre)
Gold tables: genre_popularity (genre-level rating counts, averages, and rankings)

Option 3: Run DBT Tests (Recommended)

Validate your DBT models:dbt test
Check for data quality issues before generating documentation or running DAGs.

Step 4: Orchestration with Airflow
Option 1: Local Airflow

DAGs are located in dags/.

Initialize Airflow and start webserver/scheduler:
airflow db init
airflow scheduler
airflow webserver

Trigger the DAGs manually from the Airflow UI to orchestrate:

Bronze layer ingestion
DBT transformations (Silver and Gold layers)
DBT tests

Optional documentation generation

Option 2: Cloud / Managed Airflow

Upload the DAGs to your managed Airflow environment (e.g., MWAA, Astronomer, or Databricks jobs).
Configure connections for Databricks and DBT.
Trigger DAGs via the scheduler to automate the full ETL workflow end-to-end.
