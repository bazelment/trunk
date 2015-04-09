#trunk

A collection of C++/Java opensource projects with BUILD files so they
can be easily built with [bazel](http://bazel.io).

To try:

```sh
$ git clone https://github.com/mzhaom/trunk && cd trunk
$ git submodule update --init
$ bazel build examples/...:all
```

Currently C++ projects can be only built on Linux x64 system.

##C++
  * [gflags](http://gflags.github.io/gflags/)
  * [glog](https://github.com/google/glog)
  * [googlemock](https://code.google.com/p/googlemock/)
  * [googletest](https://code.google.com/p/googletest/)
  * [grpc](http://www.grpc.io/)
  * [libevent](http://libevent.org/): version 1
  * [libunwind](http://www.nongnu.org/libunwind)
  * [protobuf](https://github.com/google/protobuf)
  * [re2](https://github.com/google/snappy)
  * [snappy](https://github.com/google/snappy)