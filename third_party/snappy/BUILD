package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_library(
  name="snappy",
  hdrs = [
    "upstream/snappy.h",
    "upstream/snappy-sinksource.h",
    "upstream/snappy-c.h",
  ],
  srcs = [
    "linux-k8/config.h",
    "linux-k8/snappy-stubs-public.h",
    "upstream/snappy-c.cc",
    "upstream/snappy-internal.h",
    "upstream/snappy-sinksource.cc",
    "upstream/snappy-stubs-internal.cc",
    "upstream/snappy-stubs-internal.h",
    "upstream/snappy.cc",
  ],
  copts = [
    "-Ithird_party/snappy/linux-k8",
    "-DHAVE_CONFIG_H",
    "-Wno-unused-function"
  ],
  deps = [
  ]
)
