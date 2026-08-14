load("@rules_python//python:py_binary.bzl", "py_binary")
load("//tools/build_rules:run_under.bzl", "run_under_test")

py_binary(
    name = "env",
    srcs = [
        "env.py",
    ],
)

run_under_test(
    name = "hello_test",
    command = "//examples:hello",
    data = [
        ":env",
    ],
    under = ":env",
)
