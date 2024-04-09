from datetime import date, timedelta
from google.cloud import bigquery
import pandas as pd

print("Creating BigQuery Connection")
client = bigquery.Client()
project = ""
table = f"{project}.news_dev.date_table"

print("Starting date job")
start_date = date(2000, 1, 1)

# Calculate the cutoff date (30 years later, one day before)
cutoff_date = start_date + timedelta(days=(30 * 365 - 1))

# Generate a sequence of dates from the start date to the cutoff date
date_sequence = [start_date + timedelta(days=i) for i in range((cutoff_date - start_date).days + 1)]

df = pd.DataFrame(columns=["the_date", "the_day", "the_day_name", "the_week", "the_iso_week", 
                           "the_day_of_week", "the_month", "the_month_name", "the_quarter", "the_quarter_name", 
                           "the_year", "the_first_of_month", "the_last_of_year", "the_day_of_year"])

print("Starting date appending step")
for d in date_sequence:
    the_date = d
    the_day = d.day
    the_day_name = d.strftime("%A")
    the_week = d.isocalendar()[1]
    the_iso_week = d.isocalendar()[1]
    the_day_of_week = d.weekday() + 1  # Monday = 1, Sunday = 7
    the_month = d.month
    the_month_name = d.strftime("%B")
    the_quarter = (d.month - 1) // 3 + 1
    the_quarter_name = 'Q' + str(((d.month - 1) // 3 + 1)).replace(".0","")
    the_year = d.year
    the_first_of_month = date(d.year, d.month, 1)
    the_last_of_year = date(d.year, 12, 31)
    the_day_of_year = d.timetuple().tm_yday

    df.loc[len(df)] = [the_date, d.day, the_day_name, the_week, the_iso_week, the_day_of_week,
                                                the_month, the_month_name, the_quarter,the_quarter_name, the_year,
                                                the_first_of_month, the_last_of_year, the_day_of_year]

print("Date appending step ran successfully")
job_config = bigquery.LoadJobConfig()
job_config.write_disposition = bigquery.WriteDisposition.WRITE_TRUNCATE
print("Trying to insert into BigQuery")
client.load_table_from_dataframe(df, table, job_config=job_config)
print("Job ran successfully")