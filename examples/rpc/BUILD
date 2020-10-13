load("@com_github_grpc_grpc//bazel:grpc_build_system.bzl", "grpc_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_library")

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
      "//base:init",
      "//external:glog",
      "//external:grpc++",
      "@com_google_absl//absl/flags:flag",
  ]
)

cc_binary(
  name = "bank-client",
  srcs = [
    "bank-client.cc"
  ],
  deps = [
      ":bank",
      "//base:init",
      "//external:glog",
      "//external:grpc++",
      "@com_google_absl//absl/flags:flag",
  ]
)
