licenses(["notice"])

cc_library(
  name = "gmock",
  testonly = 1,
  visibility = ["//visibility:public"],
  hdrs = [
    "upstream/include/gmock/gmock-actions.h",
    "upstream/include/gmock/gmock-cardinalities.h",
    "upstream/include/gmock/gmock-generated-actions.h",
    "upstream/include/gmock/gmock-generated-function-mockers.h",
    "upstream/include/gmock/gmock-generated-matchers.h",
    "upstream/include/gmock/gmock-generated-nice-strict.h",
    "upstream/include/gmock/gmock.h",
    "upstream/include/gmock/gmock-matchers.h",
    "upstream/include/gmock/gmock-more-actions.h",
    "upstream/include/gmock/gmock-more-matchers.h",
    "upstream/include/gmock/gmock-spec-builders.h",
  ],
  srcs = glob(["upstream/include/gmock/internal/*.h"]) + [
    "upstream/src/gmock-cardinalities.cc",
    "upstream/src/gmock.cc",
    "upstream/src/gmock-internal-utils.cc",
    "upstream/src/gmock-matchers.cc",
    "upstream/src/gmock-spec-builders.cc",
  ],
  deps = [
    "//third_party/gtest",
  ],
  includes = [
    "upstream/include",
  ],
)

cc_library(
  name = "gmock_main",
  visibility = ["//visibility:public"],
  deps = [
    ":gmock",
  ],
  srcs = [
    "upstream/src/gmock_main.cc",
  ],
)

