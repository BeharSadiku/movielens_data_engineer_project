from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
import os

# ======================================================
# Default arguments
# ======================================================
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}

# ======================================================
# Bronze CSV check function
# ======================================================
def check_bronze_files(raise_error=False):
    """
    Check if all required bronze CSV files exist.
    The DAG fails if files are missing, raise error.
    """
    required_files = ["links.csv", "movies.csv", "tags.csv", "ratings.csv"]
    bronze_folder = "/opt/airflow/data"

    missing_files = [
        f for f in required_files
        if not os.path.isfile(os.path.join(bronze_folder, f))
    ]

    if missing_files:
        message = f"Missing bronze CSV files: {missing_files}"
        if raise_error:
            raise FileNotFoundError(message)
        else:
            print(f"WARNING: {message}")
    else:
        print("All bronze CSV files exist.")

# ======================================================
# DAG definition
# ======================================================
with DAG(
    dag_id="bronze_silver_gold_pipeline",
    default_args=default_args,
    start_date=datetime(2025, 9, 23),
    schedule_interval=None,
    catchup=False,
    tags=["etl", "dbt", "databricks"],
) as dag:

    # Step 1: Optional bronze check
    check_bronze = PythonOperator(
        task_id="check_bronze_files",
        python_callable=check_bronze_files,
        op_kwargs={"raise_error": False},
    )

    # Step 2: Run all Silver models
    run_silver = BashOperator(
        task_id="run_silver_models",
        bash_command=(
            "/home/airflow/.local/bin/dbt run "
            "--project-dir /opt/airflow/dbt "
            "--profiles-dir /opt/airflow/dbt "
            "--models tag:silver"
        ),
        retries=2,
        retry_delay=timedelta(minutes=5),
    )

    # Step 3: Run all Gold models
    run_gold = BashOperator(
        task_id="run_gold_models",
        bash_command=(
            "/home/airflow/.local/bin/dbt run "
            "--project-dir /opt/airflow/dbt "
            "--profiles-dir /opt/airflow/dbt "
            "--models tag:gold"
        ),
        retries=2,
        retry_delay=timedelta(minutes=5),
    )

    # Step 4: Test Silver models
    test_silver = BashOperator(
        task_id="test_silver_models",
        bash_command=(
            "/home/airflow/.local/bin/dbt test "
            "--project-dir /opt/airflow/dbt "
            "--profiles-dir /opt/airflow/dbt "
            "--models tag:silver"
        ),
        retries=1,
        retry_delay=timedelta(minutes=2),
    )

    # Step 5: Test Gold models
    test_gold = BashOperator(
        task_id="test_gold_models",
        bash_command=(
            "/home/airflow/.local/bin/dbt test "
            "--project-dir /opt/airflow/dbt "
            "--profiles-dir /opt/airflow/dbt "
            "--models tag:gold"
        ),
        retries=1,
        retry_delay=timedelta(minutes=2),
    )

    # ======================================================
    # Task dependencies (strict sequential flow)
    # ======================================================
    check_bronze >> run_silver >> run_gold >> test_silver >> test_gold
