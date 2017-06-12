FROM ubuntu:16.04

RUN apt-get update && apt-get -y install git

ADD . /trunk
WORKDIR /trunk

RUN git submodule update --init
