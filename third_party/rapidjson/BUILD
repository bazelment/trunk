licenses(["notice"])

cc_library(
    name = "rapidjson",
    hdrs = glob([
        "upstream/include/rapidjson/*.h",
        "upstream/include/rapidjson/**/*.h",
    ]),
    includes = [
        "upstream/include",
    ],
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "rapidjson_example_tutorial",
    srcs = [
        "upstream/example/tutorial/tutorial.cpp",
    ],
    deps = [
        ":rapidjson",
    ],
)
