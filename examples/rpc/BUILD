load("//tools/build_rules/grpc:grpc_build_system.bzl", "grpc_proto_library")

grpc_proto_library(
  name = "bank",
  srcs = [
    "bank.proto",
  ],
)

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
