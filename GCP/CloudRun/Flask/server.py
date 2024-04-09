from flask import Flask, request, Response
from google.cloud import bigquery
from urllib.parse import unquote
import os

app = Flask(__name__)
client = bigquery.Client()
project = os.environ["PROJECT_ID"]

@app.route("/all")
def all():
    page = int(request.headers.get('page'))
    page_upper = page*20
    page_lower = ((page-1)*20)+1
    select = f"SELECT * EXCEPT(created_at, number, subcategory, news_site) FROM `{project}.news_prd.news_numbered`"
    df = client.query( select + f" WHERE number BETWEEN {page_lower} and {page_upper}").to_dataframe()
    df['date'] = df['date'].astype(str)
    return Response(df.to_json(orient="records"), mimetype="application/json")

@app.route("/search")
def search():
    value = request.headers.get('value')
    value = unquote(value)
    page = int(request.headers.get('page'))
    page_upper = page*20
    page_lower = ((page-1)*20)+1
    select = f'''WITH cte AS (SELECT * EXCEPT(created_at, number, subcategory, news_site), 
                    row_number() OVER (ORDER BY date DESC) as row_num FROM `{project}.news_prd.news_numbered`  WHERE title LIKE '%{value}%') '''
    df = client.query(select + f"SELECT * EXCEPT(row_num) FROM cte WHERE row_num BETWEEN {page_lower} and {page_upper}").to_dataframe()
    df['date'] = df['date'].astype(str)
    return Response(df.to_json(orient="records"), mimetype="application/json")

@app.route("/getcategories")
def getcategories():
    df = client.query(f"SELECT DISTINCT category FROM `{project}.news_prd.news_numbered`").to_dataframe()
    return Response(df.to_json(orient="records"), mimetype="application/json")

@app.route("/category")
def category():
    category = request.headers.get('value')
    category = unquote(category)
    page = int(request.headers.get('page'))
    page_upper = page*20
    page_lower = ((page-1)*20)+1
    select = f'''WITH cte AS (SELECT * EXCEPT(created_at, number, news_site, category), row_number() OVER (ORDER BY date DESC) as row_num 
                    FROM `{project}.news_prd.news_numbered` WHERE category='{category}') '''
    df = client.query(select + f"SELECT * EXCEPT(row_num) FROM cte WHERE row_num BETWEEN {page_lower} and {page_upper}").to_dataframe()
    df['date'] = df['date'].astype(str)
    return Response(df.to_json(orient="records"), mimetype="application/json")

if __name__ == "__main__":
  app.run(host="0.0.0.0", port=5000)