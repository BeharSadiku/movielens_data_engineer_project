# Catalog and schema where Bronze tables should reside
catalog = "workspace"
schema = "movielens_volume"

# Retrieve all tables in the schema
tables = spark.sql(f"SHOW TABLES IN {catalog}.{schema}").collect()

# Filter only Bronze tables (names starting with 'bronze_')
bronze_tables = [t for t in tables if t.tableName.startswith("bronze_")]

if not bronze_tables:
    raise Exception(f"No Bronze tables found in schema {catalog}.{schema}.")
else:
    print(f"{len(bronze_tables)} Bronze table(s) in schema {catalog}.{schema}:")
    for table in bronze_tables:
        print(f"  {table.tableName}")
