licenses(["notice"])

cc_library(
  name = "gtest",
  testonly = 1,
  visibility = ["//visibility:public"],
  includes = [
    "upstream/include",
  ],
  hdrs = [
    "upstream/include/gtest/gtest-death-test.h",
    "upstream/include/gtest/gtest-message.h",
    "upstream/include/gtest/gtest_pred_impl.h",
    "upstream/include/gtest/gtest-test-part.h",
    "upstream/include/gtest/gtest.h",
    "upstream/include/gtest/gtest-param-test.h",
    "upstream/include/gtest/gtest-printers.h",
    "upstream/include/gtest/gtest-spi.h",
    "upstream/include/gtest/gtest-typed-test.h"
  ],
  srcs = glob([
    "upstream/include/gtest/internal/*.h"]) + [
    "upstream/src/gtest-death-test.cc",
    "upstream/src/gtest-filepath.cc",
    "upstream/src/gtest-port.cc",
    "upstream/src/gtest-printers.cc",
    "upstream/src/gtest-test-part.cc",
    "upstream/src/gtest-typed-test.cc",
    "upstream/src/gtest.cc",
  ],
  copts = [
    "-Ithird_party/gtest/upstream"
  ],
  deps = [
    "//third_party/gflags",
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
    "upstream/src/gtest_main.cc",
  ],
)

cc_library(
  name = "gtest_prod",
  visibility = ["//visibility:public"],
  hdrs = [
    "upstream/include/gtest/gtest_prod.h",
  ],
)

