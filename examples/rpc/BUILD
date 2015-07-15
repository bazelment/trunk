load("/third_party/grpc/grpc_proto", "proto_library")

proto_library(
  name = "bank",
  src = "bank.proto")

cc_binary(
  name = "bank-server",
  srcs = [
    "bank-server.cc"
  ],
  deps = [
    ":bank",
    "//third_party/glog",
    "//third_party/gflags"
  ]
)

cc_binary(
  name = "bank-client",
  srcs = [
    "bank-client.cc"
  ],
  deps = [
    ":bank",
    "//third_party/glog",
    "//third_party/gflags"
  ]
)