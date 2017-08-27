licenses(["notice"])

cc_library(
  name = "gtest",
  testonly = 1,
  visibility = ["//visibility:public"],
  includes = [
    "github/googletest/include",
  ],
  hdrs = [
    "github/googletest/include/gtest/gtest-death-test.h",
    "github/googletest/include/gtest/gtest-message.h",
    "github/googletest/include/gtest/gtest_pred_impl.h",
    "github/googletest/include/gtest/gtest-test-part.h",
    "github/googletest/include/gtest/gtest.h",
    "github/googletest/include/gtest/gtest-param-test.h",
    "github/googletest/include/gtest/gtest-printers.h",
    "github/googletest/include/gtest/gtest-spi.h",
    "github/googletest/include/gtest/gtest-typed-test.h"
  ],
  srcs = glob([
    "github/googletest/include/gtest/internal/**/*.h"
  ]) +[
    "github/googletest/src/gtest-internal-inl.h",
    "github/googletest/src/gtest-death-test.cc",
    "github/googletest/src/gtest-filepath.cc",
    "github/googletest/src/gtest-port.cc",
    "github/googletest/src/gtest-printers.cc",
    "github/googletest/src/gtest-test-part.cc",
    "github/googletest/src/gtest-typed-test.cc",
    "github/googletest/src/gtest.cc",
  ],
  copts = [
    "-Ithird_party/gtest/github/googletest"
  ],
  linkopts = [
    "-pthread"
  ],
  deps = [
    "//third_party/gflags",
    ":gtest_prod",
  ],
)

cc_library(
  name = "gtest_main",
  testonly = 1,
  visibility = ["//visibility:public"],
  deps = [
    ":gtest",
  ],
  srcs = [
    "github/googletest/src/gtest_main.cc",
  ],
)

cc_library(
  name = "gtest_prod",
  visibility = ["//visibility:public"],
  hdrs = [
    "github/googletest/include/gtest/gtest_prod.h",
  ],
)

cc_library(
  name = "gmock",
  testonly = 1,
  visibility = ["//visibility:public"],
  hdrs = [
    "github/googlemock/include/gmock/gmock-actions.h",
    "github/googlemock/include/gmock/gmock-cardinalities.h",
    "github/googlemock/include/gmock/gmock-generated-actions.h",
    "github/googlemock/include/gmock/gmock-generated-function-mockers.h",
    "github/googlemock/include/gmock/gmock-generated-matchers.h",
    "github/googlemock/include/gmock/gmock-generated-nice-strict.h",
    "github/googlemock/include/gmock/gmock.h",
    "github/googlemock/include/gmock/gmock-matchers.h",
    "github/googlemock/include/gmock/gmock-more-actions.h",
    "github/googlemock/include/gmock/gmock-more-matchers.h",
    "github/googlemock/include/gmock/gmock-spec-builders.h",
  ],
  srcs = glob([
    "github/googlemock/include/gmock/internal/**/*.h"
  ]) + [
    "github/googlemock/src/gmock-cardinalities.cc",
    "github/googlemock/src/gmock.cc",
    "github/googlemock/src/gmock-internal-utils.cc",
    "github/googlemock/src/gmock-matchers.cc",
    "github/googlemock/src/gmock-spec-builders.cc",
  ],
  deps = [
    ":gtest",
  ],
  includes = [
    "github/googlemock/include",
  ],
)

cc_library(
  name = "gmock_main",
  testonly = 1,
  visibility = ["//visibility:public"],
  deps = [
    ":gmock",
  ],
  srcs = [
    "github/googlemock/src/gmock_main.cc",
  ],
)
