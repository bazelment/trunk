licenses(["notice"])

boost_path = "upstream"

cc_library(
  name = "algorithm",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/algorithm/include",
  ],
  hdrs = glob([
    boost_path + "/algorithm/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":function",
    ":range",
  ]
)

cc_library(
  name = "assert",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/assert/include",
  ],
  hdrs = glob([
    boost_path + "/assert/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "bind",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/bind/include",
  ],
  hdrs = glob([
    boost_path + "/bind/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "concept_check",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/concept_check/include",
  ],
  hdrs = glob([
    boost_path + "/concept_check/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "config",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/config/include",
  ],
  hdrs = glob([
    boost_path + "/config/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "container",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/container/include",
  ],
  hdrs = glob([
    boost_path + "/container/include/boost/*.h",
  ]),
  srcs = [
  ],
)

CONTEXT_K8_LINUX_ASM = [
  boost_path + "/context/src/asm/jump_x86_64_sysv_elf_gas.S",
  boost_path + "/context/src/asm/make_x86_64_sysv_elf_gas.S",
]

cc_library(
  name = "context",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/context/include",
  ],
  hdrs = glob([
    boost_path + "/context/include/boost/*.h",
  ]),
  srcs = [
    boost_path + "/context/src/execution_context.cpp",
  ] + CONTEXT_K8_LINUX_ASM,
  deps = [
    ":config"
  ],
  copts = [
    "-fsplit-stack",
    "-DBOOST_USE_SEGMENTED_STACKS",
  ],
)

cc_library(
  name = "conversion",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/conversion/include",
  ],
  hdrs = glob([
    boost_path + "/conversion/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "core",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/core/include",
  ],
  hdrs = glob([
    boost_path + "/core/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "detail",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/detail/include",
  ],
  hdrs = glob([
    boost_path + "/detail/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "filesystem",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/filesystem/include",
  ],
  hdrs = glob([
    boost_path + "/filesystem/include/boost/*.h",
  ]),
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

cc_library(
  name = "foreach",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/foreach/include",
  ],
  hdrs = glob([
    boost_path + "/foreach/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "function",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/function/include",
  ],
  hdrs = glob([
    boost_path + "/function/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":bind",
  ],
)

cc_library(
  name = "function_types",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/function_types/include",
  ],
  hdrs = glob([
    boost_path + "/function_types/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "functional",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/functional/include",
  ],
  hdrs = glob([
    boost_path + "/functional/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":detail",
  ],
)

cc_library(
  name = "heap",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/heap/include",
  ],
  hdrs = glob([
    boost_path + "/heap/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":parameter",
  ],
)

cc_library(
  name = "integer",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/integer/include",
  ],
  hdrs = glob([
    boost_path + "/integer/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":static_assert"
  ],
)

cc_library(
  name = "iterator",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/iterator/include",
  ],
  hdrs = glob([
    boost_path + "/iterator/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":detail",
    ":static_assert",
  ],
)

cc_library(
  name = "intrusive",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/intrusive/include",
  ],
  hdrs = glob([
    boost_path + "/intrusive/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":assert",
    ":static_assert"
  ],
)

cc_library(
  name = "io",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/io/include",
  ],
  hdrs = glob([
    boost_path + "/io/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "math",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/math/include",
  ],
  hdrs = glob([
    boost_path + "/math/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "move",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/move/include",
  ],
  hdrs = glob([
    boost_path + "/move/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "mpl",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/mpl/include",
  ],
  hdrs = glob([
    boost_path + "/mpl/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":preprocessor",
    ":move",
  ]
)

cc_library(
  name = "multi_index",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/multi_index/include",
  ],
  hdrs = glob([
    boost_path + "/multi_index/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":foreach",
    ":serialization",
    ":static_assert",
    ":tuple",
  ],
)

cc_library(
  name = "optional",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/optional/include",
  ],
  hdrs = glob([
    boost_path + "/optional/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "parameter",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/parameter/include",
  ],
  hdrs = glob([
    boost_path + "/parameter/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "predef",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/predef/include",
  ],
  hdrs = glob([
    boost_path + "/predef/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "preprocessor",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/preprocessor/include",
  ],
  hdrs = glob([
    boost_path + "/preprocessor/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "range",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/range/include",
  ],
  hdrs = glob([
    boost_path + "/range/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":concept_check",
    ":optional",
  ]
)

cc_library(
  name = "regex",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/regex/include",
  ],
  defines = [
    "BOOST_FALLTHROUGH"
  ],
  hdrs = glob([
    boost_path + "/regex/include/*.h",
  ]),
  srcs = glob([
    boost_path + "/regex/src/*.cpp",
  ]),
  deps = [
    ":assert",
    ":config",
    ":functional",
    ":integer",
    ":mpl",
    ":smart_ptr",
    ":throw_exception",
    ":type_traits",
  ]
)

cc_library(
  name = "serialization",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/serialization/include",
  ],
  hdrs = glob([
    boost_path + "/serialization/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "smart_ptr",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/smart_ptr/include",
  ],
  hdrs = glob([
    boost_path + "/smart_ptr/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":core",
    ":predef",
    ":throw_exception",
    ":utility",
  ],
)

cc_library(
  name = "static_assert",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/static_assert/include",
  ],
  hdrs = glob([
    boost_path + "/static_assert/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "system",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/system/include",
  ],
  hdrs = glob([
    boost_path + "/system/include/boost/*.h",
  ]),
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

cc_library(
  name = "throw_exception",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/throw_exception/include",
  ],
  hdrs = glob([
    boost_path + "/throw_exception/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "type_index",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/type_index/include",
  ],
  hdrs = glob([
    boost_path + "/type_index/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":core",
  ]
)

cc_library(
  name = "type_traits",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/type_traits/include",
  ],
  hdrs = glob([
    boost_path + "/type_traits/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":core",
    ":mpl",
    ":static_assert",
  ]
)

cc_library(
  name = "tuple",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/tuple/include",
  ],
  hdrs = glob([
    boost_path + "/tuple/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
  ],
)

cc_library(
  name = "tr1",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/tr1/include",
  ],
  defines = [
    "BOOST_FALLTHROUGH"
  ],
  hdrs = glob([
    boost_path + "/tr1/include/boost/tr1/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":config",
  ]
)

cc_library(
  name = "utility",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/utility/include",
  ],
  hdrs = glob([
    boost_path + "/utility/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "variant",
  visibility = ["//visibility:public"],
  includes = [
    boost_path + "/variant/include",
  ],
  hdrs = glob([
    boost_path + "/variant/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":math",
    ":type_index",
  ]
)
