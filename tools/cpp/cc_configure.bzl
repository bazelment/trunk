# Copyright 2016 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Rules for configuring the C++ toolchain (experimental)."""


def _get_value(it):
  """Convert `it` in serialized protobuf format."""
  if type(it) == "int":
    return str(it)
  elif type(it) == "bool":
    return "true" if it else "false"
  else:
    return "\"%s\"" % it


def _build_crosstool(d, prefix="  "):
  """Convert `d` to a string version of a CROSSTOOL file content."""
  lines = []
  for k in d:
    if type(d[k]) == "list":
      for it in d[k]:
        lines.append("%s%s: %s" % (prefix, k, _get_value(it)))
    else:
      lines.append("%s%s: %s" % (prefix, k, _get_value(d[k])))
  return "\n".join(lines)


def _build_tool_path(d):
  """Build the list of tool_path for the CROSSTOOL file."""
  lines = []
  for k in d:
    lines.append("  tool_path {name: \"%s\" path: \"%s\" }" % (k, d[k]))
  return "\n".join(lines)


def _which(repository_ctx, cmd, default):
  """A wrapper around repository_ctx.which() to provide a fallback value."""
  result = repository_ctx.which(cmd)
  return default if result == None else str(result)


def _get_tool_paths(repository_ctx, darwin, cc):
  """Compute the path to the various tools."""
  return {k: _which(repository_ctx, k, "/usr/bin/" + k)
          for k in [
              "ld",
              "cpp",
              "dwp",
              "gcov",
              "nm",
              "objcopy",
              "objdump",
              "strip",
          ]} + {
              "gcc": cc,
              "ar": "/usr/bin/libtool"
                    if darwin else _which(repository_ctx, "ar", "/usr/bin/ar")
          }


def _ld_library_paths(repository_ctx):
  """Use ${LD_LIBRARY_PATH} to compute the list -Wl,rpath flags."""
  if "LD_LIBRARY_PATH" in repository_ctx.os.environ:
    result = []
    for p in repository_ctx.os.environ["LD_LIBRARY_PATH"].split(":"):
      p = str(repository_ctx.path(p))  # Normalize the path
      result.append("-Wl,-rpath," + p)
      result.append("-L" + p)
    return result
  else:
    return []


def _cplus_include_paths(repository_ctx):
  """Use ${CPLUS_INCLUDE_PATH} to compute the list of flags for cxxflag."""
  if "CPLUS_INCLUDE_PATH" in repository_ctx.os.environ:
    result = []
    for p in repository_ctx.os.environ["CPLUS_INCLUDE_PATH"].split(":"):
      p = str(repository_ctx.path(p))  # Normalize the path
      result.append("-I" + p)
    return result
  else:
    return []


def _get_cpu_value(repository_ctx):
  """Compute the cpu_value based on the OS name."""
  os_name = repository_ctx.os.name.lower()
  if os_name.startswith("mac os"):
    return "darwin"
  if os_name.find("freebsd") != -1:
    return "freebsd"
  if os_name.find("windows") != -1:
    return "x64_windows"
  # Use uname to figure out whether we are on x86_32 or x86_64
  result = repository_ctx.execute(["uname", "-m"])
  return "piii" if result.stdout.strip() == "i386" else "k8"


_INC_DIR_MARKER_BEGIN = "#include <...> search starts here:"
_INC_DIR_MARKER_END = "End of search list."

# OSX add " (framework directory)" at the end of line, strip it.
_OSX_FRAMEWORK_SUFFIX = " (framework directory)"
_OSX_FRAMEWORK_SUFFIX_LEN =  len(_OSX_FRAMEWORK_SUFFIX)
def _cxx_inc_convert(path):
  """Convert path returned by cc -E xc++ in a complete path."""
  path = path.strip()
  if path.endswith(_OSX_FRAMEWORK_SUFFIX):
    path = path[:-_OSX_FRAMEWORK_SUFFIX_LEN].strip()
  return path

def _get_cxx_inc_directories(repository_ctx, cc):
  """Compute the list of default C++ include directories."""
  result = repository_ctx.execute([cc, "-E", "-xc++", "-", "-v"])
  index1 = result.stderr.find(_INC_DIR_MARKER_BEGIN)
  if index1 == -1:
    return []
  index2 = result.stderr.find(_INC_DIR_MARKER_END, index1)
  if index2 == -1:
    return []
  inc_dirs = result.stderr[index1 + len(_INC_DIR_MARKER_BEGIN):index2].strip()
  return [repository_ctx.path(_cxx_inc_convert(p))
          for p in inc_dirs.split("\n")]

def _add_option_if_supported(repository_ctx, cc, option):
  """Checks that `option` is supported by the C compiler."""
  result = repository_ctx.execute([
      cc,
      option,
      "-o",
      "/dev/null",
      "-c",
      str(repository_ctx.path("tools/cpp/empty.cc"))
  ])
  return [option] if result.stderr.find(option) == -1 else []


def _crosstool_content(repository_ctx, cc, cpu_value, darwin):
  """Return the content for the CROSSTOOL file, in a dictionary."""
  return {
      "abi_version": "local",
      "abi_libc_version": "local",
      "builtin_sysroot": "",
      "compiler": "compiler",
      "host_system_name": "local",
      "needsPic": True,
      "supports_gold_linker": False,
      "supports_incremental_linker": False,
      "supports_fission": False,
      "supports_interface_shared_objects": False,
      "supports_normalizing_ar": False,
      "supports_start_end_lib": False,
      "supports_thin_archives": False,
      "target_libc": "macosx" if darwin else "local",
      "target_cpu": cpu_value,
      "target_system_name": "local",
      "cxx_flag": [
          "-std=c++0x",
      ] + _cplus_include_paths(repository_ctx),
      "linker_flag": [
          "-lstdc++",
          # Anticipated future default.
      ] + _add_option_if_supported(repository_ctx, cc, "-no-canonical-prefixes") + (
          ["-undefined", "dynamic_lookup"] if darwin else [
              "-B" + str(repository_ctx.path(cc).dirname),
              # Always have -B/usr/bin, see https://github.com/bazelbuild/bazel/issues/760.
              "-B/usr/bin",
              # Have gcc return the exit code from ld.
              "-pass-exit-codes",
              # Stamp the binary with a unique identifier.
              "-Wl,--build-id=md5",
              "-Wl,--hash-style=gnu"
              # Gold linker only? Can we enable this by default?
              # "-Wl,--warn-execstack",
              # "-Wl,--detect-odr-violations"
          ]) + _ld_library_paths(repository_ctx),
      "ar_flag": ["-static", "-s", "-o"] if darwin else [],
      "cxx_builtin_include_directory": _get_cxx_inc_directories(repository_ctx, cc),
      "objcopy_embed_flag": ["-I", "binary"],
      "unfiltered_cxx_flag":
          # Anticipated future default.
          _add_option_if_supported(repository_ctx, cc, "-no-canonical-prefixes") +
          _add_option_if_supported(repository_ctx, cc, "-fno-canonical-system-headers") + [
              # Make C++ compilation deterministic. Use linkstamping instead of these
              # compiler symbols.
              "-Wno-builtin-macro-redefined",
              "-D__DATE__=\\\"redacted\\\"",
              "-D__TIMESTAMP__=\\\"redacted\\\"",
              "-D__TIME__=\\\"redacted\\\""
          ],
      "compiler_flag": [
          # Security hardening on by default.
          # Conservative choice; -D_FORTIFY_SOURCE=2 may be unsafe in some cases.
          # We need to undef it before redefining it as some distributions now have
          # it enabled by default.
          "-U_FORTIFY_SOURCE",
          "-D_FORTIFY_SOURCE=1",
          "-fstack-protector",
          # All warnings are enabled. Maybe enable -Werror as well?
          "-Wall",
          # Enable a few more warnings that aren't part of -Wall.
      ] + (["-Wthread-safety", "-Wself-assign"] if darwin else [
          # Disable some that are problematic.
          "-Wl,-z,-relro,-z,now",
          "-B" + str(repository_ctx.path(cc).dirname),
          # Always have -B/usr/bin, see https://github.com/bazelbuild/bazel/issues/760.
          "-B/usr/bin",
      ]) + (
          _add_option_if_supported(repository_ctx, cc, "-Wunused-but-set-parameter") +
          # has false positives
          _add_option_if_supported(repository_ctx, cc, "-Wno-free-nonheap-object") +
          # Enable coloring even if there's no attached terminal. Bazel removes the
          # escape sequences if --nocolor is specified.
          _add_option_if_supported(repository_ctx, cc, "-fcolor-diagnostics")) + [
              # Keep stack frames for debugging, even in opt mode.
              "-fno-omit-frame-pointer",
          ],
  }


def _opt_content(darwin):
  """Return the content of the opt specific section of the CROSSTOOL file."""
  return {
      "compiler_flag": [
          # No debug symbols.
          # Maybe we should enable https://gcc.gnu.org/wiki/DebugFission for opt or
          # even generally? However, that can't happen here, as it requires special
          # handling in Bazel.
          "-g0",

          # Conservative choice for -O
          # -O3 can increase binary size and even slow down the resulting binaries.
          # Profile first and / or use FDO if you need better performance than this.
          "-O2",

          # Disable assertions
          "-DNDEBUG",

          # Removal of unused code and data at link time (can this increase binary size in some cases?).
          "-ffunction-sections",
          "-fdata-sections"
      ],
      "linker_flag": [] if darwin else ["-Wl,--gc-sections"]
  }


def _dbg_content():
  """Return the content of the dbg specific section of the CROSSTOOL file."""
  # Enable debug symbols
  return {"compiler_flag": "-g"}


def _find_cc(repository_ctx):
  """Find the C++ compiler."""
  cc_name = "gcc"
  if "CC" in repository_ctx.os.environ:
    cc_name = repository_ctx.os.environ["CC"]
  if cc_name.startswith("/"):
    # Absolute path, maybe we should make this suported by our which function.
    return cc_name
  cc = repository_ctx.which(cc_name)
  if cc == None:
    fail(
        "Cannot find gcc, either correct your path or set the CC" +
        " environment variable")
  return cc


def _tpl(repository_ctx, tpl, substitutions={}):
  repository_ctx.template(
      tpl,
      Label("@bazel_tools//tools/cpp:%s.tpl" % tpl),
      substitutions)


def _impl(repository_ctx):
  repository_ctx.file("tools/cpp/empty.cc")
  cpu_value = _get_cpu_value(repository_ctx)
  if cpu_value in ["freebsd", "x64_windows"]:
    # This is defaulting to the static crosstool, we should eventually do those platform too.
    # Theorically, FreeBSD should be straightforward to add but we cannot run it in a docker
    # container so escaping until we have proper tests for FreeBSD.
    # Windows support is still experimental, let's not fiddle with autoconfiguration for now.
    repository_ctx.symlink(Label("@bazel_tools//tools/cpp:CROSSTOOL"), "CROSSTOOL")
    repository_ctx.symlink(Label("@bazel_tools//tools/cpp:BUILD.static"), "BUILD")
  else:
    darwin = cpu_value == "darwin"
    cc = _find_cc(repository_ctx)
    crosstool_cc = "osx_cc_wrapper.sh" if darwin else str(cc)
    darwin = cpu_value == "darwin"
    tool_paths = _get_tool_paths(repository_ctx, darwin, crosstool_cc)
    crosstool_content = _crosstool_content(repository_ctx, cc, cpu_value, darwin)
    opt_content = _opt_content(darwin)
    dbg_content = _dbg_content()
    _tpl(repository_ctx, "BUILD", {
        "%{name}": cpu_value,
        "%{supports_param_files}": "0" if darwin else "1"
    })
    _tpl(repository_ctx, "osx_cc_wrapper.sh", {"%{cc}": str(cc)})
    _tpl(repository_ctx, "CROSSTOOL", {
        "%{cpu}": cpu_value,
        "%{content}": _build_crosstool(crosstool_content) + "\n" +
                      _build_tool_path(tool_paths),
        "%{opt_content}": _build_crosstool(opt_content, "    "),
        "%{dbg_content}": _build_crosstool(dbg_content, "    "),
    })


cc_autoconf = repository_rule(implementation=_impl, local=True)


def cc_configure():
  """A C++ configuration rules that generate the crosstool file."""
  cc_autoconf(name="local_config_cc")
  native.bind(name="cc_toolchain", actual="@local_config_cc//:toolchain")
