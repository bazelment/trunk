licenses(["notice"])

cc_library(
  name = "acceptor",
  visibility = ["//visibility:public"],
  includes = [
    "upstream",
  ],
  srcs = glob(["upstream/wangle/acceptor/*.cpp"]),
  deps = [
    "//third_party/folly:async",
    "//third_party/boost:parameter",
  ]
)

cc_library(
  name = "wangle",
  visibility = ["//visibility:public"],
  deps = [
    ":acceptor",
  ]
)
