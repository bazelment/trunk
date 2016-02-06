licenses(["notice"])

config_setting(
  name = "linux_x32",
  values = {"cpu": "piii"},
)

config_setting(
  name = "linux_x64",
  values = {"cpu": "k8"},
)

config_setting(
  name = "linux_arm",
  values = {"cpu": "arm"},
)

config_setting(
  name = "linux_aarch64",
  values = {"cpu": "aarch64"},
)

boringssl_copts = [
]

load('BUILD.generated', 'ssl_headers', 'ssl_internal_headers', 'ssl_sources',
     'crypto_headers', 'crypto_internal_headers', 'crypto_sources',
     'tool_sources', 'crypto_sources_linux_aarch64', 'crypto_sources_linux_arm',
     'crypto_sources_linux_x86', 'crypto_sources_linux_x86_64')

cc_library(
  name = 'crypto',
  visibility = ["//visibility:public"],
  hdrs = crypto_headers,
  srcs = crypto_internal_headers + crypto_sources + select({
    ":linux_x32": crypto_sources_linux_x86,
    ":linux_x64": crypto_sources_linux_x86_64,
    ":linux_arm": crypto_sources_linux_arm,
    ":linux_aarch64": crypto_sources_linux_aarch64,
    "//conditions:default": crypto_sources_linux_x86_64,
  }),
  defines = [
    'BORINGSSL_IMPLEMENTATION',
    'BORINGSSL_NO_STATIC_INITIALIZER',
  ],
  includes = [
    'src/include'
  ],
  copts = boringssl_copts,
  linkopts = [
    '-pthread'
  ]
)

cc_library(
  name = 'ssl',
  visibility = ["//visibility:public"],
  hdrs = ssl_headers,
  srcs = ssl_internal_headers + ssl_sources,
  defines = [
    'BORINGSSL_IMPLEMENTATION',
    'BORINGSSL_NO_STATIC_INITIALIZER',
  ],
  includes = [
    'src/include'
  ],
  copts = boringssl_copts,
  linkopts = [
    '-pthread'
  ],
  deps = [
    ':crypto',
  ]
)

cc_binary(
  name = 'tool',
  srcs = tool_sources + [
    'src/tool/internal.h',
    'src/tool/transport_common.h',
  ],
  deps = [
    ':crypto',
    ':ssl',
  ]
)

load('BUILD.generated_tests', 'create_tests')

create_tests(
  copts = [],
)
