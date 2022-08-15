#!/bin/bash -e

SCRIPT_DIR_NAME=$(cd "$(dirname "$0")" || exit 1; pwd -P)
RELEASE="$(cat ${SCRIPT_DIR_NAME}/.bazelversion)"
echo "Installing bazel ${RELEASE}"
wget https://github.com/bazelbuild/bazel/releases/download/${RELEASE}/bazel-${RELEASE}-installer-linux-x86_64.sh
wget https://github.com/bazelbuild/bazel/releases/download/${RELEASE}/bazel-${RELEASE}-installer-linux-x86_64.sh.sha256
sha256sum -c bazel-${RELEASE}-installer-linux-x86_64.sh.sha256
chmod +x bazel-${RELEASE}-installer-linux-x86_64.sh
./bazel-${RELEASE}-installer-linux-x86_64.sh --user
