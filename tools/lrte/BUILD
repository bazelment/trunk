package(default_visibility = ["//visibility:public"])

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

cc_toolchain_suite(
  name = "toolchain",
  toolchains = {
    "local|compiler": ":cc-compiler-local",
    "k8|clang": ":cc-compiler-k8",
    "k8|gcc": ":cc-compiler-k8",
  },
)

# The crosstool is loaded by following --crosstool_top, loading the
# definition inside CROSSTOOL proto file, and matched based on the
# required settings, which are defined compiler, cpu, glibc version.

# These rules defines filegroups, which contain files that will be
# used by selected toolchain when it's compiling. The filegroup is
# selected based as "cc-compiler-target-cpu"
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
  # Instead parsing all compiler/linker options through command line,
  # enabling this option will make bazel write most of the options to
  # a param file, and invoke the toolchain with the param file, which
  # avoids potential issue when the list becomes longer than the
  # system limit.
  supports_param_files = 1,
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
  supports_param_files = 1,
)


filegroup(
  name = "srcs",
  srcs = glob(["**"]),
)
