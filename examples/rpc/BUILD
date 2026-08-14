load("@com_github_grpc_grpc//bazel:cc_grpc_library.bzl", "cc_grpc_library")
load("@com_github_grpc_grpc//bazel:python_rules.bzl", "py_grpc_library", "py_proto_library")
load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

# cc_grpc_library() expands into the following build targets:
#   proto_library:     "bank_only"
#   cc_proto_library:  "bank_cc_proto"
#   generate_cc (generates the grpc header/cpp files): "_bank_grpc_codegen"
#   cc_library (for the generated grpc stub files):    "bank"
cc_grpc_library(
    name = "bank",
    srcs = [
        "bank.proto",
    ],
    deps = [],
)

cc_binary(
    name = "bank-server",
    srcs = [
        "bank-server.cc",
    ],
    deps = [
        ":bank",
        "//base:init",
        "@com_github_grpc_grpc//:grpc++",
        "@com_google_absl//absl/flags:flag",
        "@com_google_glog//:glog",
    ],
)

cc_binary(
    name = "bank-client",
    srcs = [
        "bank-client.cc",
    ],
    deps = [
        ":bank",
        "//base:init",
        "@com_github_grpc_grpc//:grpc++",
        "@com_google_absl//absl/flags:flag",
        "@com_google_glog//:glog",
    ],
)

# Demonstrate how to use a python client to access grpc.
py_proto_library(
    name = "bank_py_proto",
    deps = [
        ":bank_only",
    ],
)

py_grpc_library(
    name = "bank_py_grpc",
    srcs = [":bank_only"],
    deps = [":bank_py_proto"],
)
