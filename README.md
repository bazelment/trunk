# trunk

A collection of C++/Java opensource projects with BUILD files so they
can be easily built with [bazel](https://bazel.build).

To try:

```sh
$ git clone https://github.com/mzhaom/trunk && cd trunk
$ git submodule update --init third_party/abseil third_party/protobuf \
    third_party/grpc third_party/gtest/github third_party/glog/upstream \
    third_party/gflags/upstream
$ bazel build //examples/...
```

Building the folly stack additionally needs:

```sh
$ git submodule update --init third_party/folly/upstream \
    third_party/fizz/upstream third_party/wangle/upstream \
    third_party/proxygen/upstream
$ bazel build @proxygen//:proxygen
```

Currently C++ projects can be only built on Linux x64 system.

## Prerequisites

  * Bazel — the version in [`.bazelversion`](.bazelversion) is what the
    tree is built and tested with; use
    [bazelisk](https://github.com/bazelbuild/bazelisk) or run
    [`./install-bazel.sh`](install-bazel.sh), which reads that file.
  * A C++20 compiler (gcc >= 11 or clang; gcc 13 is what this is tested
    with).  Pass `--config=clang` to build with a downloaded clang release
    instead of the system compiler.
  * `python3-dev`.  protobuf builds its python runtime against the *system*
    python, so the interpreter headers have to be present:
    `sudo apt-get install python3-dev`.

## How dependencies are wired up

Dependencies are materialized in the tree as git submodules under
`third_party/` rather than being downloaded as opaque archives.  Bazel 9
dropped `WORKSPACE`, so this is expressed in [`MODULE.bazel`](MODULE.bazel)
with `local_path_override`: every module listed with an override resolves to
the checked out submodule, never to an archive from the Bazel Central
Registry.  Only rule sets and the leaf dependencies of the vendored modules
still come from the registry.

Projects that ship no Bazel build of their own (currently folly, fizz,
wangle and proxygen) are pulled from a fork under
[github.com/bazelment](https://github.com/bazelment) whose `bazel-<tag>`
branch carries the upstream release tag plus the Bazel overlay and patches.
Those four are version locked to each other and have to be bumped as a set.

`WORKSPACE.legacy` is the pre-bzlmod setup, kept for reference while the
remaining `third_party` projects are ported.

## C++
  * [abseil](https://abseil.io/)
  * [gflags](https://gflags.github.io/gflags/)
  * [glog](https://github.com/google/glog)
  * [googletest](https://github.com/google/googletest) (and googlemock)
  * [gperftools](https://github.com/gperftools/gperftools) tcmalloc, heap-checker, heap-profiler and cpu-profiler.
  * [grpc](https://grpc.io/)
  * [libevent](https://libevent.org/): version 1
  * [libunwind](https://www.nongnu.org/libunwind)
  * [protobuf](https://github.com/protocolbuffers/protobuf)
  * [re2](https://github.com/google/re2)
  * [snappy](https://github.com/google/snappy)

  * [folly](https://github.com/facebook/folly) and the libraries built on it:
    [fizz](https://github.com/facebookincubator/fizz),
    [wangle](https://github.com/facebook/wangle) and
    [proxygen](https://github.com/facebook/proxygen).
  * [double-conversion](https://github.com/google/double-conversion/)
  * A selection of [boost](https://www.boost.org/) modules, mostly for building folly.

## Java
  * [grpc-java](https://grpc.io/) gRPC in Java
  * [guava](https://github.com/google/guava) Guava: Google Core Libraries for Java
  * [netty](https://netty.io/) Netty is a NIO client server framework
    which enables quick and easy development of network applications
    such as protocol servers and clients.
