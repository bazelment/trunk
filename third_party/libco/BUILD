licenses(["notice"])

cc_library(
    name = "libco",
    srcs = [
        "upstream/co_closure.h",
        "upstream/co_epoll.cpp",
        "upstream/co_epoll.h",
        "upstream/co_hook_sys_call.cpp",
        "upstream/co_routine.cpp",
        "upstream/co_routine_inner.h",
        "upstream/co_routine_specific.h",
        "upstream/coctx.cpp",
        "upstream/coctx.h",
        "upstream/coctx_swap.S",
    ],
    hdrs = [
        "upstream/co_routine.h",
    ],
    includes = ["upstream/"],
    linkopts = [
        "-pthread",
        "-ldl",
    ],
    visibility = ["//visibility:public"],
)
