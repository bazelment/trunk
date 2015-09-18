licenses(["notice"])

cc_library(
  name = "algorithm",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/algorithm/include",
  ],
  hdrs = glob([
    "upstream/algorithm/include/boost/*.h",
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
    "upstream/assert/include",
  ],
  hdrs = glob([
    "upstream/assert/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "bind",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/bind/include",
  ],
  hdrs = glob([
    "upstream/bind/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "concept_check",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/concept_check/include",
  ],
  hdrs = glob([
    "upstream/concept_check/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "config",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/config/include",
  ],
  hdrs = glob([
    "upstream/config/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "container",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/container/include",
  ],
  hdrs = glob([
    "upstream/container/include/boost/*.h",
  ]),
  srcs = [
  ],
)

CONTEXT_K8_LINUX_ASM = [
  "upstream/context/src/asm/jump_x86_64_sysv_elf_gas.S",
  "upstream/context/src/asm/make_x86_64_sysv_elf_gas.S",
]

cc_library(
  name = "context",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/context/include",
  ],
  hdrs = glob([
    "upstream/context/include/boost/*.h",
  ]),
  srcs = [
    "upstream/context/src/execution_context.cpp",
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
    "upstream/conversion/include",
  ],
  hdrs = glob([
    "upstream/conversion/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "core",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/core/include",
  ],
  hdrs = glob([
    "upstream/core/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "detail",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/detail/include",
  ],
  hdrs = glob([
    "upstream/detail/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "filesystem",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/filesystem/include",
  ],
  hdrs = glob([
    "upstream/filesystem/include/boost/*.h",
  ]),
  srcs = glob([
    "upstream/filesystem/src/*.cpp",
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
    "upstream/foreach/include",
  ],
  hdrs = glob([
    "upstream/foreach/include/boost/*.h",
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
    "upstream/function/include",
  ],
  hdrs = glob([
    "upstream/function/include/boost/*.h",
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
    "upstream/function_types/include",
  ],
  hdrs = glob([
    "upstream/function_types/include/boost/*.h",
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
    "upstream/functional/include",
  ],
  hdrs = glob([
    "upstream/functional/include/boost/*.h",
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
    "upstream/heap/include",
  ],
  hdrs = glob([
    "upstream/heap/include/boost/*.h",
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
    "upstream/integer/include",
  ],
  hdrs = glob([
    "upstream/integer/include/boost/*.h",
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
    "upstream/iterator/include",
  ],
  hdrs = glob([
    "upstream/iterator/include/boost/*.h",
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
    "upstream/intrusive/include",
  ],
  hdrs = glob([
    "upstream/intrusive/include/boost/*.h",
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
    "upstream/io/include",
  ],
  hdrs = glob([
    "upstream/io/include/boost/*.h",
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
    "upstream/math/include",
  ],
  hdrs = glob([
    "upstream/math/include/boost/*.h",
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
    "upstream/move/include",
  ],
  hdrs = glob([
    "upstream/move/include/boost/*.h",
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
    "upstream/mpl/include",
  ],
  hdrs = glob([
    "upstream/mpl/include/boost/*.h",
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
    "upstream/multi_index/include",
  ],
  hdrs = glob([
    "upstream/multi_index/include/boost/*.h",
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
    "upstream/optional/include",
  ],
  hdrs = glob([
    "upstream/optional/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "parameter",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/parameter/include",
  ],
  hdrs = glob([
    "upstream/parameter/include/boost/*.h",
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
    "upstream/predef/include",
  ],
  hdrs = glob([
    "upstream/predef/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "preprocessor",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/preprocessor/include",
  ],
  hdrs = glob([
    "upstream/preprocessor/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "range",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/range/include",
  ],
  hdrs = glob([
    "upstream/range/include/boost/*.h",
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
    "upstream/regex/include",
  ],
  defines = [
    "BOOST_FALLTHROUGH"
  ],
  hdrs = glob([
    "upstream/regex/include/*.h",
  ]),
  srcs = glob([
    "upstream/regex/src/*.cpp",
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
    "upstream/serialization/include",
  ],
  hdrs = glob([
    "upstream/serialization/include/boost/*.h",
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
    "upstream/smart_ptr/include",
  ],
  hdrs = glob([
    "upstream/smart_ptr/include/boost/*.h",
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
    "upstream/static_assert/include",
  ],
  hdrs = glob([
    "upstream/static_assert/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "system",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/system/include",
  ],
  hdrs = glob([
    "upstream/system/include/boost/*.h",
  ]),
  srcs = glob([
    "upstream/system/src/*.cpp",
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
    "upstream/throw_exception/include",
  ],
  hdrs = glob([
    "upstream/throw_exception/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "type_index",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/type_index/include",
  ],
  hdrs = glob([
    "upstream/type_index/include/boost/*.h",
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
    "upstream/type_traits/include",
  ],
  hdrs = glob([
    "upstream/type_traits/include/boost/*.h",
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
    "upstream/tuple/include",
  ],
  hdrs = glob([
    "upstream/tuple/include/boost/*.h",
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
    "upstream/tr1/include",
  ],
  defines = [
    "BOOST_FALLTHROUGH"
  ],
  hdrs = glob([
    "upstream/tr1/include/boost/tr1/*.h",
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
    "upstream/utility/include",
  ],
  hdrs = glob([
    "upstream/utility/include/boost/*.h",
  ]),
  srcs = [
  ],
)

cc_library(
  name = "variant",
  visibility = ["//visibility:public"],
  includes = [
    "upstream/variant/include",
  ],
  hdrs = glob([
    "upstream/variant/include/boost/*.h",
  ]),
  srcs = [
  ],
  deps = [
    ":math",
    ":type_index",
  ]
)
