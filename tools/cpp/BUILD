package(default_visibility = ["//visibility:public"])

# This can used to enable some conditional setting based on when
# asan/msan/tsan/ubsan is used.
config_setting(
  name = "asan_enabled",
  values = {
    "copt" : "-fsanitize=address",
  }
)

config_setting(
  name = "msan_enabled",
  values = {
    "copt" : "-fsanitize=memory",
  }
)

config_setting(
  name = "tsan_enabled",
  values = {
    "copt" : "-fsanitize=thread",
  }
)

config_setting(
  name = "ubsan_enabled",
  values = {
    "copt" : "-fsanitize=undefined",
  }
)

config_setting(
  name = "debug_enabled",
  values = {
    "compilation_mode": "dbg"
  }
)

# This can used to enable some conditional setting for ARM CPU
config_setting(
  name = "arm",
  values = {
    "cpu": "arm",
  }
)

# This can used to enable some conditional setting for X86 32 bit CPU
config_setting(
  name = "x86_32",
  values = {
    "cpu": "piii",
  }
)


# TODO(bazel-team): The MacOS tools give an error if there is no object file on
# the command line to libtool, so we use an empty .cc file here. We should find
# a better way to handle this case.
cc_library(
    name = "malloc",
    srcs = ["empty.cc"],
)

cc_library(
    name = "stl",
    srcs = ["empty.cc"],
)

filegroup(
    name = "empty",
    srcs = [],
)

# This is the entry point for --crosstool_top.  Toolchains are found
# by lopping off the name of --crosstool_top and searching for
# "cc-compiler-${CPU}" in this BUILD file, where CPU is the target CPU
# specified in --cpu.
#
# This file group should include
#   * all cc_toolchain targets supported
#   * all file groups that said cc_toolchain might refer to,
# including the default_grte_top setting in the CROSSTOOL
# protobuf.
filegroup(
    name = "toolchain",
    srcs = [
        ":cc-compiler-armeabi-v7a",
        ":cc-compiler-darwin",
        ":cc-compiler-freebsd",
        ":cc-compiler-local",
        ":empty",
    ],
)

cc_toolchain(
    name = "cc-compiler-local",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "local",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain(
    name = "cc-compiler-armeabi-v7a",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "local",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain(
    name = "cc-compiler-k8",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "local",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain(
    name = "cc-compiler-darwin",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "darwin",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain(
    name = "cc-compiler-freebsd",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "local",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)

filegroup(
    name = "srcs",
    srcs = glob(["**"]),
)
