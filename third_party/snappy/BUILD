package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_library(
  name="snappy",
  hdrs = [
    "upstream/snappy.h",
    "upstream/snappy-sinksource.h",
    "upstream/snappy-c.h"
  ],
  srcs = [
    "upstream/snappy.cc",
    "upstream/snappy-sinksource.cc", 
    "upstream/snappy-stubs-internal.cc",
    "upstream/snappy-c.cc"
  ],
  copts = [
    "-Ithird_party/snappy/linux-k8",
    "-DHAVE_CONFIG_H",
    "-Wno-unused-function"
  ],
  deps = [
  ]
)
