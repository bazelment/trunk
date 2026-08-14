load("@rules_cc//cc:cc_library.bzl", "cc_library")

cc_library(
    name = "build_info",
    hdrs = [
        "build_info.h",
    ],
    linkstamp = "build_info.cc",
    visibility = ["//visibility:public"],
)

cc_library(
    name = "init",
    srcs = [
        "init.cc",
    ],
    hdrs = [
        "init.h",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@com_google_absl//absl/debugging:failure_signal_handler",
        "@com_google_absl//absl/debugging:symbolize",
        "@com_google_absl//absl/flags:parse",
        "@com_google_glog//:glog",
    ],
)
