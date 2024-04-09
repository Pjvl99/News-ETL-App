# News-ETL-App

- This project consist of an ETL that starts from that starts from scrapy jobs extracting data from multiple news sites and ends in a mobile news application.

- Diagram:
![NewsAppDiagram](https://github.com/Pjvl99/News-ETL-App/assets/61527863/a6f1aeb5-aa54-45fc-9ca5-4e010cb4b47b)

- Steps to run the project:
  1. Install python https://www.python.org/downloads/
  2. Install docker https://docs.docker.com/engine/install/
  3. Install flutter https://docs.flutter.dev/get-started/install.
  4. Set your own GCP Project and create a GCS Bucket.
  5. Set the env variables in the dockerfiles (GCP/CloudRun) based on your GCP Project (Bucket and Project ID).
  6. Deploy each gcp folder to it's respective service.
  7. Run docker build -t flask_server -f CloudRun/Flask/Dockerfile
  8. Run docker build -t scrapy_job -f CloudRun/Flask/Dockerfile
  9. Based on your name of your two images, run this command (for each image): docker tag SOURCE-IMAGE LOCATION-docker.pkg.dev/PROJECT-ID/REPOSITORY/IMAGE:TAG
  10. Deploy each folder in it's respective service.
  11. Deploy the flutter application using firebase (just update the url variable based on the cloud run url).

- The objective of this project was to build an api from scratch for news.
1. This is how cloud run scrapy job looks like, this job is uploading the files to GCS:
   
![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/4f5388f2-7615-4aae-b49e-3c2a3d17fbee)

2. This is how the files look like inside GCS:
![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/ef4c6d06-a4f6-4a9b-aa4f-c0bc47ecbb52)


3. There's one cloud function uploading the data coming from GCS automatically:
   
![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/fadef86e-26b4-4245-86f6-01db882b3921)

4. There's one query running on a daily basis in order to upload the prd dataset:
   
![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/cbb4a822-ed08-48ee-b7a6-7e0ec564d5f3)

5. This is how the news data looks inside bigquery:
   
![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/5c6a0eec-e6b4-4628-8825-e546fb54f3a2)

6. This is how the flask server looks inside cloud run:
   
![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/09f82431-b37e-4efb-8826-b3300b72ad55)


7. This is how the final application mobile looks like:

![Screenshot from 2024-02-27 09-00-39](https://github.com/Pjvl99/News-ETL-App/assets/61527863/babb91fb-f202-43a9-8739-0bc3d5e7a778)

8. There's also a looker report containing insights about the news data:

![image](https://github.com/Pjvl99/News-ETL-App/assets/61527863/f1b6391a-06ea-4ce5-a556-4ef341bded0b)

