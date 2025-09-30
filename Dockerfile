FROM apache/airflow:2.8.1

USER airflow
# Upgrade pip and install dbt + databricks adapter
RUN pip install --upgrade --user pip \
    && pip install --user dbt-core==1.5.2 dbt-databricks==1.5.2 databricks-cli
