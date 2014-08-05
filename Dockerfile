FROM ubuntu/trusty
MAINTAINER Cameron A. Pope <cameron@theaboutbox.com>

# Download latest package lists
RUN apt-get update

# Install dependencies
RUN apt-get install -yq \
    openjdk-7-jre-headless \
    wget \
    gettext-base

# Download version 1.4.2 of logstash
RUN cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
    tar -xzvf ./logstash-1.4.2.tar.gz && \
    mv ./logstash-1.4.2 /opt/logstash && \
    rm ./logstash-1.4.2.tar.gz

# Copy build files to container root
RUN mkdir /app
ADD . /app

# Elasticsearch
EXPOSE 9200

# Kibana
EXPOSE 9292

# Syslog
EXPOSE 514

# Start logstash
ENTRYPOINT ["/app/bin/run"]
