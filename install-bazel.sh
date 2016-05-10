#!/bin/bash -e
RELEASE=0.2.2b
wget https://github.com/bazelbuild/bazel/releases/download/${RELEASE}/bazel-${RELEASE}-installer-linux-x86_64.sh
wget https://github.com/bazelbuild/bazel/releases/download/${RELEASE}/bazel-${RELEASE}-installer-linux-x86_64.sh.sha256
sha256sum -c bazel-${RELEASE}-installer-linux-x86_64.sh.sha256
chmod +x bazel-${RELEASE}-installer-linux-x86_64.sh
./bazel-${RELEASE}-installer-linux-x86_64.sh --user
