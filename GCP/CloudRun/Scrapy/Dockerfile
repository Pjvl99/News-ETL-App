FROM ubuntu:22.04
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
ARG DEBIAN_FRONTEND=noninteractive
ARG PROJECT_ID=
ARG BUCKET_NAME=
RUN apt-get update \
  && apt install python3 python3-pip -y \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install scrapy \
    && pip3 install google-cloud \
    && pip3 install google-cloud-storage

RUN mkdir -p /jobs/scrapy
WORKDIR /jobs/scrapy/
COPY news_app/ ./news_app
WORKDIR /jobs/scrapy/news_app/
CMD [ "bash", "setup.sh" ]


