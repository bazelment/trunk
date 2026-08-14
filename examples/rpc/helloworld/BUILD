load("@com_github_grpc_grpc//bazel:cc_grpc_library.bzl", "cc_grpc_library")
load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

cc_grpc_library(
    name = "helloworld",
    srcs = [
        "helloworld.proto",
    ],
    deps = [],
)

cc_binary(
    name = "greeter_client",
    srcs = [
        "greeter_client.cc",
    ],
    deps = [
        ":helloworld",
        "@com_github_grpc_grpc//:grpc++",
    ],
)

cc_binary(
    name = "greeter_server",
    srcs = [
        "greeter_server.cc",
    ],
    deps = [
        ":helloworld",
        "@com_github_grpc_grpc//:grpc++",
    ],
)

cc_binary(
    name = "greeter_async_client",
    srcs = [
        "greeter_async_client.cc",
    ],
    deps = [
        ":helloworld",
        "@com_github_grpc_grpc//:grpc++",
        "@com_google_absl//absl/log:check",
    ],
)

cc_binary(
    name = "greeter_async_server",
    srcs = [
        "greeter_async_server.cc",
    ],
    deps = [
        ":helloworld",
        "@com_github_grpc_grpc//:grpc++",
        "@com_google_absl//absl/log:check",
    ],
)

# TODO: fix grpc-java
# java_binary(
#   name = "greeter_client_java",
#   srcs = [
#     "java/io/grpc/examples/helloworld/HelloWorldClient.java"
#   ],
#   main_class = "io.grpc.examples.helloworld.HelloWorldClient",
#   deps = [
#     ":helloworld_java",
#     "//third_party/java/grpc-java",
#   ]
# )

# java_binary(
#   name = "greeter_server_java",
#   srcs = [
#     "java/io/grpc/examples/helloworld/HelloWorldServer.java"
#   ],
#   main_class = "io.grpc.examples.helloworld.HelloWorldServer",
#   deps = [
#     ":helloworld_java",
#     "//third_party/java/grpc-java",
#   ]
# )
