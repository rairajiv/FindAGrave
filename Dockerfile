# The base image on which this image is based
FROM www.cybage-docker-registry.com:9080/ubuntu

MAINTAINER Rajiv Rai <rajivra@cybage.com>

#install wget 
RUN apt-get update && apt-get -y install wget openssh-server

# Download mongodb, extract it, move it and cleanup 
RUN wget   http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.4.8.tgz -O /tmp/mongodb-linux-x86_84.tgz && \
    tar zxf /tmp/mongodb-linux-x86_84.tgz  && \
    mv mongodb-linux-x86_64-2.4.8 /opt/mongodb && \
    rm -rf /tmp/*

# The following volumes should not be considered part of the image, but contain runtime data.
# For best usage, this volume should be mounted to a host directory upon running the container.

RUN mkdir -p /data/db
VOLUME ["/data/db"]

EXPOSE 27017

CMD ["/opt/mongodb/bin/mongod"]
