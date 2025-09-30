"""
download_movielens.py
Downloads MovieLens 32M dataset and extracts CSVs to raw_data/.
"""

import os
import requests
import zipfile

# Paths
folder = "raw_data"
os.makedirs(folder, exist_ok=True)

url = "https://files.grouplens.org/datasets/movielens/ml-32m.zip"
zip_path = os.path.join(folder, "ml-32m.zip")

# Download if missing
if not os.path.exists(zip_path):
    r = requests.get(url, stream=True)
    r.raise_for_status()
    with open(zip_path, "wb") as f:
        for part in r.iter_content():
            f.write(part)

# Extract CSVs
with zipfile.ZipFile(zip_path) as z:
    for name in ["ratings.csv", "movies.csv", "tags.csv", "links.csv"]:
        file = [f for f in z.namelist() if f.endswith(name)][0]
        z.extract(file, folder)
        os.replace(os.path.join(folder, file), os.path.join(folder, name))

# Remove zip
os.remove(zip_path)
