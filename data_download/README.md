### Option 1: Automatic download (Recommended)

The easiest way to get the dataset is to run the Python script included in this folder. This will:

- Download the MovieLens 32M dataset.
- Extract the required CSV files directly into the `raw_data/` folder.

```bash
python download_movielens.py

Option 2: Manual download

If you prefer to download the dataset yourself:
Visit MovieLens 32M and download ml-32m.zip.

Extract the following CSV files into the raw_data/ folder:
ratings.csv
movies.csv
tags.csv
links.csv

Note: The raw_data/ folder must contain all four CSV files before running the Bronze ingestion script.
