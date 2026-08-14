load("@rules_cc//cc:cc_binary.bzl", "cc_binary")
load("@rules_cc//cc:cc_test.bzl", "cc_test")

package(default_visibility = ["//visibility:public"])

cc_binary(
    name = "hello",
    srcs = [
        "hello.cc",
    ],
    stamp = 1,
    deps = [
        "//base:build_info",
        "//base:init",
        "@com_google_glog//:glog",
    ],
)

cc_test(
    name = "hello_test",
    srcs = [
        "hello_test.cc",
    ],
    deps = [
        "@com_google_googletest//:gtest_main",
    ],
)
