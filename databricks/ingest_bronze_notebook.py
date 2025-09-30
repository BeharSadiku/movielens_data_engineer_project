"""
Databricks Notebook - Bronze Layer Ingestion (Unity Catalog)
To run: Copy this script into a Databricks notebook cell by cell
"""

# COMMAND ----------
# Imports
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_unixtime, to_timestamp, expr

# COMMAND ----------
# Create Spark session
spark = SparkSession.builder.getOrCreate()

# COMMAND ----------
# Define DBFS path for raw CSVs
raw_base = "dbfs:/Volumes/workspace/default/movielens_volume/raw"

# COMMAND ----------
# Ingest Ratings
ratings_df = spark.read.option("header", "true").csv(f"{raw_base}/ratings.csv")
ratings_clean = ratings_df.select(
    expr("try_cast(userId AS BIGINT) AS user_id"),
    expr("try_cast(movieId AS BIGINT) AS movie_id"),
    expr("try_cast(rating AS DOUBLE) AS rating"),
    expr("try_cast(timestamp AS BIGINT) AS timestamp_unix")
).withColumn(
    "rated_at", to_timestamp(from_unixtime(col("timestamp_unix")))
).drop("timestamp_unix")

# Save as UC Delta table
ratings_clean.write.format("delta") \
    .mode("overwrite") \
    .saveAsTable("workspace.movielens_volume.bronze_ratings")

print("Bronze ratings table created in UC.")

# COMMAND ----------
# Ingest Movies
movies_df = spark.read.option("header", "true").csv(f"{raw_base}/movies.csv")
movies_clean = movies_df.select(
    expr("try_cast(movieId AS BIGINT) AS movie_id"),
    col("title"),
    col("genres")
)

movies_clean.write.format("delta") \
    .mode("overwrite") \
    .saveAsTable("workspace.movielens_volume.bronze_movies")

print("Bronze movies table created in UC.")

# COMMAND ----------
# Ingest Tags
tags_df = spark.read.option("header", "true").csv(f"{raw_base}/tags.csv")
tags_clean = tags_df.select(
    expr("try_cast(userId AS BIGINT) AS user_id"),
    expr("try_cast(movieId AS BIGINT) AS movie_id"),
    col("tag"),
    expr("try_cast(timestamp AS BIGINT) AS timestamp_unix")
).withColumn(
    "tagged_at", to_timestamp(from_unixtime(col("timestamp_unix")))
).drop("timestamp_unix")

tags_clean.write.format("delta") \
    .mode("overwrite") \
    .saveAsTable("workspace.movielens_volume.bronze_tags")

print("Bronze tags table created in UC.")

# COMMAND ----------
# Ingest Links
links_df = spark.read.option("header", "true").csv(f"{raw_base}/links.csv")
links_clean = links_df.select(
    expr("try_cast(movieId AS BIGINT) AS movie_id"),
    col("imdbId"),
    col("tmdbId")
)

links_clean.write.format("delta") \
    .mode("overwrite") \
    .saveAsTable("workspace.movielens_volume.bronze_links")

print("Bronze links table created in UC.")

# COMMAND ----------
# Optional: Quick checks
print("Sample data from Bronze tables:")
spark.sql("SELECT * FROM workspace.movielens_volume.bronze_ratings LIMIT 5").show()
spark.sql("SELECT * FROM workspace.movielens_volume.bronze_movies LIMIT 5").show()
spark.sql("SELECT * FROM workspace.movielens_volume.bronze_tags LIMIT 5").show()
spark.sql("SELECT * FROM workspace.movielens_volume.bronze_links LIMIT 5").show()

print("All Bronze tables ingested successfully in Unity Catalog.")
