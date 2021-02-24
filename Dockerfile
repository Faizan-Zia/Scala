FROM ubuntu:20.04
# Env variables
ENV SBT_VERSION 1.1.5
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

# Install curl
#RUN apt-get install libc6:amd64 -y
#RUN rm /var/cache/debconf/*

# Install sbt
RUN apt-get update &&\
  apt-get install -y default-jre curl sudo postgresql postgresql-contrib tzdata &&\
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb &&\
  dpkg -i sbt-$SBT_VERSION.deb &&\
  rm sbt-$SBT_VERSION.deb &&\
  apt-get install -y sbt &&\
  service postgresql start &&\
  sudo -i -u postgres psql -c "create database impure;" &&\
  sudo -i -u postgres psql -c "create user impure with encrypted password 'secret'; grant all privileges on database impure to impure;" &&\
  sudo -i -u postgres psql -c "create database pure;" &&\
  sudo -i -u postgres psql -c "create user pure with encrypted password 'secret'; grant all privileges on database pure to pure;" &&\
  sudo -i -u postgres psql -c "create database tapir;" &&\
  sudo -i -u postgres psql -c "create user tapir with encrypted password 'secret'; grant all privileges on database tapir to tapir;"
WORKDIR /opt/docker
ADD --chown=daemon:daemon opt /opt
USER root
CMD []
