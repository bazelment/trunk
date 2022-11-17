licenses(["notice"])

cc_binary(
  name = "echo_server",
  visibility = ["//visibility:public"],
  srcs = ["EchoServer.cpp"],
  deps = [
    "//third_party/wangle:wangle",
    "//third_party/folly:folly",
    "//third_party/glog:glog"
  ]
)

cc_binary(
  name = "echo_client",
  visibility = ["//visibility:public"],
  srcs = ["EchoClient.cpp"],
  deps = [
    "//third_party/wangle:wangle",
    "//third_party/folly:folly",
    "//third_party/glog:glog"
  ]
)


