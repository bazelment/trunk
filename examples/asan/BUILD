load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

cc_binary(
    name = "use-after-free",
    srcs = [
        "use-after-free.cc",
    ],
)

cc_binary(
    name = "leak",
    testonly = 1,
    srcs = [
        "leak.cc",
    ],
    deps = [
        "//third_party/gperftools:tcmalloc_heapcheck",
    ],
)
