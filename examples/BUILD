package(default_visibility = ["//visibility:public"])

cc_binary(
  name = "hello",
  srcs = [
    "hello.cc"
  ],
  deps = [
    "//third_party/gflags",
    "//third_party/glog",
  ],
)

cc_test(
  name = "hello_test",
  srcs = [
    "hello_test.cc",
  ],
  deps = [
    "//third_party/gtest:gtest_main",
  ],
)
