package(default_visibility = ["//visibility:public"])

cc_binary(
  name = "hello",
  srcs = [
    "hello.cc"
  ],
  deps = [
    "//base:build_info",
    "//base:init",
    "//external:glog",
  ],
  stamp = 1,
)

cc_test(
  name = "hello_test",
  srcs = [
    "hello_test.cc",
  ],
  deps = [
    "//external:gtest_main",
  ],
)
