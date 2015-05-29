# define a clang based toolchain, to use:
# bazel build --crosstool_top=//third_party/chromium_browser_clang:toolchain build foo:bar

licenses(["notice"])
package(default_visibility = ["//visibility:public"])

filegroup(
  name = "toolchain",
  srcs = [
    ":cc-compiler-k8",
    ":empty",
    ":clang-linux-x64-3.7-toolchain",
  ],
)

filegroup(
  name = "clang-linux-x64-3.7-toolchain",
  srcs = glob([
    "Linux_x64/bin/*",
    "Linux_x64/lib/**/*.h",
    "Linux_x64/lib/**/*.so.*",
  ]),
  output_licenses = ["unencumbered"],
)

filegroup(
  name = "empty",
  srcs = [],
)

# "xyz" in "cc-compiler-xyz" needs to match the target_cpu in CROSSTOOL
cc_toolchain(
  name = "cc-compiler-k8",
  all_files = ":clang-linux-x64-3.7-toolchain",
  compiler_files = ":clang-linux-x64-3.7-toolchain",
  cpu = "k8",
  dwp_files = ":clang-linux-x64-3.7-toolchain",
  dynamic_runtime_libs = [":clang-linux-x64-3.7-toolchain"],
  linker_files = ":clang-linux-x64-3.7-toolchain",
  objcopy_files = ":clang-linux-x64-3.7-toolchain",
  static_runtime_libs = [":clang-linux-x64-3.7-toolchain"],
  strip_files = ":clang-linux-x64-3.7-toolchain",
  supports_param_files = 0,
)
