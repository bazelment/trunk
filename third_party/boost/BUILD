licenses(["notice"])

boost_path = "upstream"

load("//tools/build_rules:boost.bzl", "boost_library")

boost_library(
    name = "algorithm",
    deps = [
        ":assert",
        ":config",
        ":function",
        ":integer",
        ":iterator",
        ":mpl",
        ":range",
        ":throw_exception",
        ":type_traits",
        ":utility",
    ],
)

boost_library(
    name = "align",
)

boost_library(
    name = "assert",
)

boost_library(
    name = "atomic",
)

boost_library(
    name = "bind",
)

boost_library(
    name = "chrono",
    deps = [
        ":ratio",
    ],
)

boost_library(
    name = "concept_check",
)

boost_library(
    name = "config",
)

boost_library(
    name = "container",
)

CONTEXT_K8_LINUX_ASM = [
    boost_path + "/context/src/asm/jump_x86_64_sysv_elf_gas.S",
    boost_path + "/context/src/asm/make_x86_64_sysv_elf_gas.S",
]

boost_library(
    name = "context",
    srcs = [
        boost_path + "/context/src/execution_context.cpp",
    ] + CONTEXT_K8_LINUX_ASM,
    copts = [
        "-fsplit-stack",
        "-DBOOST_USE_SEGMENTED_STACKS",
    ],
    deps = [
        ":config",
    ],
)

boost_library(
    name = "conversion",
)

boost_library(
    name = "core",
    deps = [
        ":config",
    ],
)

boost_library(
    name = "date_time",
)

boost_library(
    name = "detail",
)

boost_library(
    name = "exception",
    defines = [
        "BOOST_NO_CXX11_RVALUE_REFERENCES",
    ],
)

boost_library(
    name = "filesystem",
    srcs = glob([
        boost_path + "/filesystem/src/*.cpp",
    ]),
    deps = [
        ":config",
        ":functional",
        ":io",
        ":iterator",
        ":range",
        ":smart_ptr",
        ":system",
        ":type_traits",
    ],
)

boost_library(
    name = "foreach",
)

boost_library(
    name = "function",
    deps = [
        ":bind",
    ],
)

boost_library(
    name = "function_types",
)

boost_library(
    name = "functional",
    deps = [
        ":detail",
    ],
)

boost_library(
    name = "heap",
    deps = [
        ":parameter",
    ],
)

boost_library(
    name = "integer",
    deps = [
        ":static_assert",
    ],
)

boost_library(
    name = "iterator",
    deps = [
        ":detail",
        ":static_assert",
    ],
)

boost_library(
    name = "intrusive",
    deps = [
        ":assert",
        ":static_assert",
    ],
)

boost_library(
    name = "io",
)

boost_library(
    name = "math",
)

boost_library(
    name = "move",
)

boost_library(
    name = "mpl",
    deps = [
        ":move",
        ":preprocessor",
    ],
)

boost_library(
    name = "multi_index",
    deps = [
        ":foreach",
        ":serialization",
        ":static_assert",
        ":tuple",
    ],
)

boost_library(
    name = "optional",
)

boost_library(
    name = "parameter",
)

boost_library(
    name = "predef",
)

boost_library(
    name = "preprocessor",
)

boost_library(
    name = "range",
    deps = [
        ":concept_check",
        ":optional",
    ],
)

boost_library(
    name = "ratio",
)

boost_library(
    name = "regex",
    srcs = glob([
        boost_path + "/regex/src/*.cpp",
        boost_path + "/regex/src/*.hpp",
    ]),
    defines = [
        "BOOST_FALLTHROUGH",
    ],
    deps = [
        ":assert",
        ":config",
        ":functional",
        ":integer",
        ":mpl",
        ":smart_ptr",
        ":throw_exception",
        ":type_traits",
    ],
)

boost_library(
    name = "serialization",
)

boost_library(
    name = "smart_ptr",
    deps = [
        ":align",
        ":core",
        ":predef",
        ":throw_exception",
        ":utility",
    ],
)

boost_library(
    name = "static_assert",
)

boost_library(
    name = "system",
    srcs = glob([
        boost_path + "/system/src/*.cpp",
    ]),
    deps = [
        ":assert",
        ":config",
        ":core",
        ":predef",
    ],
)

boost_library(
    name = "thread",
    defines = [
        "BOOST_NO_CXX11_RVALUE_REFERENCES",
        "BOOST_NO_CXX11_SMART_PTR",
    ],
    deps = [
        ":atomic",
        ":chrono",
        ":core",
        ":date_time",
        ":exception",
        ":io",
        ":system",
    ],
)

boost_library(
    name = "throw_exception",
)

boost_library(
    name = "type_index",
    deps = [
        ":core",
    ],
)

boost_library(
    name = "type_traits",
    deps = [
        ":core",
        ":mpl",
        ":static_assert",
    ],
)

boost_library(
    name = "tuple",
)

boost_library(
    name = "tr1",
    defines = [
        "BOOST_FALLTHROUGH",
    ],
    deps = [
        ":config",
    ],
)

boost_library(
    name = "utility",
)

boost_library(
    name = "variant",
    deps = [
        ":math",
        ":type_index",
    ],
)

boost_library(
    name = "asio",
    deps = [
        ":bind",
        ":config",
        ":date_time",
        ":filesystem",
        ":mpl",
        ":regex",
        ":smart_ptr",
        ":static_assert",
        ":throw_exception",
        ":type_traits",
    ],
)
