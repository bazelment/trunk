load("//tools/build_rules/grpc:grpc_proto.bzl", "proto_library")

proto_library(
  name = "helloworld",
  src = "helloworld.proto",
  has_service = True,
  generate_cc = True,
  # generate_java = True,
)

cc_binary(
  name = "greeter_client",
  srcs = [
    "greeter_client.cc",
  ],
  deps = [
    ":helloworld",
  ],
)

cc_binary(
  name = "greeter_server",
  srcs = [
    "greeter_server.cc",
  ],
  deps = [
    ":helloworld",
  ],
)

cc_binary(
  name = "greeter_async_client",
  srcs = [
    "greeter_async_client.cc",
  ],
  deps = [
    ":helloworld",
  ],
)

cc_binary(
  name = "greeter_async_server",
  srcs = [
    "greeter_async_server.cc",
  ],
  deps = [
    ":helloworld",
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
