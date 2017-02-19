package(default_visibility = ["//visibility:public"])

cc_binary(
  name = "hello",
  srcs = [
    "hello.cc"
  ],
  deps = [
    "//base:build_info",
    "//third_party/gflags",
    "//third_party/glog",
  ],
  stamp = 1,
)

cc_test(
  name = "hello_test",
  srcs = [
    "hello_test.cc",
  ],
  linkopts = [
    "-lpthread"
  ],
  deps = [
    "//third_party/gtest:gtest_main",
  ],
)
