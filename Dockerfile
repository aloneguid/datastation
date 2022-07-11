FROM ubuntu:jammy
# alpine sucks for Python and images will actually become larger than Ubuntu's due to no wheels available
#FROM alpine:3.16.0

# update
#RUN apk update && apk upgrade
RUN apt update && apt upgrade -y

# create operational user
#RUN adduser datauser -D
RUN useradd -ms /bin/bash datauser

# installs:
# - JDK 11 (JRE is not sufficient)
# - Python3 dev version (required by polynote's JEP) and pip
# - build-base for GCC (required by JEP)
#RUN apk add bash curl openjdk11-jdk python3 python3-dev py3-pip build-base
RUN apt install openjdk-11-jdk-headless -y
RUN apt install curl python3-pip -y
# properly configure Java (alpine)
#ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

#USER datauser

# install Polynote by downloading from github
RUN curl -L https://github.com/polynote/polynote/releases/download/0.4.5/polynote-dist.tar.gz -o polynote.tar.gz \
    && tar -xzf polynote.tar.gz \
    && rm polynote.tar.gz \
    && chmod +x polynote/polynote.py

# install polynote dependencies
RUN pip3 install -r polynote/requirements.txt

# install Apache Spark, it's easy with pip!
RUN pip3 install pip install pyspark==3.2.1
# org.apache.spark:spark-sql_2.13:3.2.1

# configure Spark from the pyspark package folder
ENV SPARK_HOME="/usr/local/lib/python3.10/dist-packages/pyspark"
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

# copy support scripts
COPY run.sh /run.sh
COPY config.yml /polynote/config.yml

ENTRYPOINT ["bash", "./run.sh"]
