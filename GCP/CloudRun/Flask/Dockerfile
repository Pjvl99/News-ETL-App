FROM ubuntu:22.04
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt install python3 python3-pip -y \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install flask \
    && pip3 install google-cloud \
    && pip3 install google-cloud-bigquery \
    && pip3 install fsspec \
    && pip3 install gcsfs \
    && pip3 install pyarrow \
    && pip3 install pandas \
    && pip3 install db_dtypes

RUN mkdir -p /www/
ADD setup.py /www/
WORKDIR /www/
EXPOSE 5000
ENV FLASK_APP=setup.py
CMD ["flask", "run", "--host", "0.0.0.0"]