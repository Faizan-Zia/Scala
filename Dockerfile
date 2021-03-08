FROM ubuntu:20.04

# Env variables
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
ENV CLONE_URL=https://github.com/Faizan-Zia/Scala.git

RUN apt-get update &&\
  apt-get install -y git default-jre curl sudo postgresql postgresql-contrib tzdata &&\
  service postgresql start &&\
  sudo -i -u postgres psql -c "create database impure;" &&\
  sudo -i -u postgres psql -c "create user impure with encrypted password 'secret'; grant all privileges on database impure to impure;" &&\
  sudo -i -u postgres psql -c "create database pure;" &&\
  sudo -i -u postgres psql -c "create user pure with encrypted password 'secret'; grant all privileges on database pure to pure;" &&\
  sudo -i -u postgres psql -c "create database tapir;" &&\
  sudo -i -u postgres psql -c "create user tapir with encrypted password 'secret'; grant all privileges on database tapir to tapir;"

RUN git clone $CLONE_URL