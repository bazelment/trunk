package(default_visibility = ["//visibility:public"])

sh_binary(
    name = "2to3",
    srcs = ["2to3.sh"],
)

sh_binary(
    name = "plink",
    srcs = ["plink_wrapper.sh"],
    data = [
        "//third_party/plink:plink.py"
    ],
)

filegroup(
    name = "srcs",
    srcs = [
        # Tools are build from the workspace for tests.
        "2to3.sh",
        "BUILD",
    ],
)
