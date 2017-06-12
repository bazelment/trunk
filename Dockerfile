FROM ubuntu:16.04

CMD git submodule update --init
ADD . /trunk
WORKDIR /trunk
