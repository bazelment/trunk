licenses(["notice"])

cc_library(
    name = "pbjson",
    srcs = [
        "upstream/src/bin2ascii.h",
        "upstream/src/pbjson.cpp",
        "upstream/src/pbjson.hpp",
    ],
    hdrs = [
        "pbjson.h",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/protobuf",
        "//third_party/rapidjson",
    ],
)
