# Databricks Scripts

This folder contains scripts to ingest the MovieLens dataset into the Bronze layer.  
There are **two versions** available, depending on your environment.

---

## 1. Databricks Notebook Version

- **File:** `ingest_bronze_notebook.py`  
- **Purpose:** Run inside a Databricks Workspace.  
- **Features:**
  - Uses DBFS paths (`dbfs:/Volumes/workspace/...`) for raw CSVs
  - Uses `dbutils` for file management
  - Creates Delta tables directly in Unity Catalog (`workspace.movielens_volume`)

### How to run

1. Upload `ingest_bronze_notebook.py` to a new Databricks notebook **or** copy its contents into notebook cells.
2. Run each cell sequentially.
3. The Bronze layer will be created in Unity Catalog: `workspace.movielens_volume`

> Ensure the raw CSVs (`ratings.csv`, `movies.csv`, `tags.csv`, `links.csv`) are already uploaded to:  
> `dbfs:/Volumes/workspace/default/movielens_volume/raw/`

---

## 2. Local PySpark Version

- **File:** `ingest_bronze_local.py`  
- **Purpose:** Run locally on your machine with PySpark installed.  
- **Features:**
  - Uses relative paths (`raw_data/` folder)
  - Does **not** require Databricks or `dbutils`
  - Creates Bronze Delta tables locally for testing or development

### Prerequisites

- Python 3.x and PySpark installed
- The `raw_data/` folder in the project root contains the four CSVs:
  - `ratings.csv`
  - `movies.csv`
  - `tags.csv`
  - `links.csv`

### How to run it

1. Open a terminal in the **project root folder**.
2. Execute the script:

```bash
python databricks/ingest_bronze_local.py
