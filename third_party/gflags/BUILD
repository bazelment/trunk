licenses(["notice"])

cc_library(
  visibility = ["//visibility:public"],
  includes = [
    "gflags_build/k8/include",
  ],
  srcs = [
    "upstream/src/gflags.cc",
    "upstream/src/gflags_completions.cc",
    "upstream/src/gflags_reporting.cc",
    # Private headers
    "gflags_build/k8/include/gflags/config.h",
    "upstream/src/mutex.h",
    "upstream/src/util.h",
  ],
  hdrs = [
    "gflags_build/k8/include/gflags/gflags.h",
    "gflags_build/k8/include/gflags/gflags_completions.h",
    "gflags_build/k8/include/gflags/gflags_declare.h",
    "gflags_build/k8/include/gflags/gflags_gflags.h",
  ],
  name = "gflags",
  copts = [
    "-Ithird_party/gflags/gflags_build/k8/include/gflags",
  ],
  linkopts = [
    "-pthread",
  ],
)

cc_test(
  srcs = [
    "upstream/test/gflags_unittest.cc",
    "upstream/test/config_for_unittests.h",
  ],
  copts = [
    "-Ithird_party/gflags/gflags_build/k8/include/gflags",  # We need "config.h"
    "-Ithird_party/gflags/upstream/src",
  ],
  name = "gflags_unittest",
  deps = [
    ":gflags"
  ],
)
