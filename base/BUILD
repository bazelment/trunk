cc_library(
  visibility = ["//visibility:public"],
  name = 'build_info',
  hdrs = [
    'build_info.h'
  ],
  linkstamp = 'build_info.c'
)

cc_library(
  visibility = ["//visibility:public"],
  name = 'init',
  hdrs = [
    'init.h'
  ],
  srcs = [
    'init.cc',
  ],
  deps = [
    "@com_google_absl//absl/debugging:failure_signal_handler",
    "@com_google_absl//absl/flags:parse",
    "//external:glog",
  ],
)
