# **********************************************************************************************************************
# Copyright  Tomas Inc., 2018.
# All Rights Reserved.
#
# Usage:
#   docker build --force-rm -t <image_name> --build-arg branch_name=<branch_name> .
# Container:
#	docker create -p 8888:8888 -v /home/tomas/.m2:/root/.m2 --name <container_name>
# **********************************************************************************************************************
FROM maven:3-jdk-8-slim
ARG branch_name
MAINTAINER Maiorino Tomas <tomasmaiorino@gmail.com>

#APPLICATION CONFIGURATION
ENV APPLICATION_REPO https://github.com/tomasmaiorino/tsm-config-server.git

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive
ENV branch_name master
ENV port 8888
ENV custom_mvn_parameters -V

# update dpkg repositories
RUN apt-get update

# install git
RUN apt-get -y install git

# remove download archive files
RUN apt-get clean

RUN mkdir /app
WORKDIR /app
RUN git clone $APPLICATION_REPO
WORKDIR /app/tsm-config-server
RUN git checkout $branch_name

ENTRYPOINT ["/bin/bash", "-c", "/app/tsm-config-server/./starting_container.sh ${branch_name} ${port} ${custom_mvn_parameters}"]