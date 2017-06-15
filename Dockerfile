FROM bazelment/lrte:latest

RUN apt-get update && apt-get -y install git

ADD . /trunk
WORKDIR /trunk

RUN git submodule update --init
