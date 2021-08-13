load("@com_github_grpc_grpc//bazel:grpc_build_system.bzl", "grpc_proto_library")

load("@rules_proto//proto:defs.bzl", "proto_library")

# See cc_grpc_library.bzl, this will create the following build targets:
# proto_library: "_bank_only"
# cc_proto_library: "_bank_cc_proto"
# generate_cc(generate grpc header/cpp files): "_bank_grpc_codegen"
# cc_library(for generate grpc stub files): "bank"

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

# Demonstrate how to use python client to access grpc.
load("@com_github_grpc_grpc//bazel:python_rules.bzl", "py_grpc_library", "py_proto_library")

py_proto_library(
    name = "bank_py_proto",
    deps = [
        ":_bank_only"
    ]
)
    
py_grpc_library(
    name = "bank_py_grpc",
    srcs = [":_bank_only"],
    deps = [":bank_py_proto"],
)

# py_binary(
#     name = "bank_client_py",
#     srcs = ["bank_client.py"],
#     python_version = "PY3",
#     srcs_version = "PY2AND3",
#     deps = [
#         # ":bank_py_pb2",
#         # ":bank_py_pb2_grpc",
#     ]
# )
