FROM ubuntu:24.04

# build-essential: gcc 13, new enough for the C++20 that folly requires.
# python3-dev: protobuf builds its python runtime against the system python.
RUN apt-get update && apt-get -y install --no-install-recommends \
      build-essential \
      ca-certificates \
      curl \
      git \
      python3 \
      python3-dev \
      unzip \
      zip \
    && rm -rf /var/lib/apt/lists/*

# Bazelisk picks up the version pinned in .bazelversion.
RUN curl -fsSL -o /usr/local/bin/bazel \
      https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 \
    && chmod +x /usr/local/bin/bazel

ADD . /trunk
WORKDIR /trunk

RUN git submodule update --init \
      third_party/abseil \
      third_party/protobuf \
      third_party/grpc \
      third_party/gtest/github \
      third_party/glog/upstream \
      third_party/gflags/upstream \
      third_party/folly/upstream \
      third_party/fizz/upstream \
      third_party/wangle/upstream \
      third_party/proxygen/upstream
