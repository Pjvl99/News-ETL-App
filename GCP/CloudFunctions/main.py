import functions_framework
import pandas as pd
from google.cloud import bigquery
from google.cloud import storage
# Triggered by a change in a storage bucket
@functions_framework.cloud_event
def hello_gcs(cloud_event):

    print("Trying to upload gcs data into bigquery")
    client = bigquery.Client()
    job_config = bigquery.LoadJobConfig()
    table = "trim-heaven-415202.news_dev.news_raw_data"

    data = cloud_event.data
    bucket = data["bucket"]
    name = data["name"]

    if "soy502" in name:
        job_config.write_disposition = bigquery.WriteDisposition.WRITE_TRUNCATE
    else:
        job_config.write_disposition = bigquery.WriteDisposition.WRITE_APPEND
    
    file_location = f"gs://{bucket}/{name}"

    df = pd.read_csv(file_location, delimiter="|")
    df['date'] = pd.to_datetime(df['date']).dt.date
    df['created_at'] = pd.Timestamp.today().date()
    job_config = client.load_table_from_dataframe(df, table, job_config=job_config)
    job_config.result()
    print("Cloud function ran successfully")