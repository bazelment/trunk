licenses(["notice"])

# Generators
genrule(
  name = "generate_format_tables",
  srcs = [
    "upstream/folly/build/generate_format_tables.py"
  ],
  cmd = "$(location upstream/folly/build/generate_format_tables.py) --install_dir=$(GENDIR)/third_party/folly",
  outs = [
    "FormatTables.cpp",
  ],
)

genrule(
  name = "generate_escape_tables",
  srcs = [
    "upstream/folly/build/generate_escape_tables.py"
  ],
  cmd = "$(location upstream/folly/build/generate_escape_tables.py) --install_dir=$(GENDIR)/third_party/folly",
  outs = [
    "EscapeTables.cpp",
  ],
)

genrule(
  name = "generate_varint_tables",
  srcs = [
    "upstream/folly/build/generate_varint_tables.py"
  ],
  cmd = "$(location upstream/folly/build/generate_varint_tables.py) --install_dir=$(GENDIR)/third_party/folly",
  outs = [
    "GroupVarintTables.cpp",
  ],
)

cc_binary(
  srcs = [
    "upstream/folly/build/GenerateFingerprintTables.cpp",
  ],
  deps = [
    ":base",
  ],
  name = "GenerateFingerprintTables",
)

genrule(
  name = "generate_fingerprint_tables",
  srcs = [
    ":GenerateFingerprintTables"
  ],
  cmd = "$(location :GenerateFingerprintTables) --install_dir=$(GENDIR)/third_party/folly",
  outs = [
    "FingerprintTables.cpp"
  ]
)

cc_library(
  name = "base",
  visibility = ["//visibility:public"],
  includes = [
    "upstream",
    "linux-k8",
  ],
  hdrs = [
  ],
  srcs = [
    ":generate_format_tables",
    ":generate_escape_tables",
    "upstream/folly/Conv.cpp",
    "upstream/folly/Demangle.cpp",
    "upstream/folly/Format.cpp",
    "upstream/folly/Malloc.cpp",
    "upstream/folly/Range.cpp",
    "upstream/folly/String.cpp",
    "upstream/folly/Unicode.cpp",
  ],
  deps = [
    "//third_party/glog",
    "//third_party/double-conversion",
  ],
)

cc_library(
  name = "FingerprintTables",
  hdrs = [
  ],
  srcs = [
    ":generate_fingerprint_tables"
  ],
  deps = [
    ":base",
  ],
)

cc_library(
  name = "folly",
  visibility = ["//visibility:public"],
  hdrs = [
  ],
  copts = [
    "-pthread",
  ],
  srcs = [
    ":generate_varint_tables",
    "upstream/folly/Bits.cpp",
    "upstream/folly/detail/CacheLocality.cpp",
    "upstream/folly/dynamic.cpp",
    "upstream/folly/File.cpp",
    "upstream/folly/FileUtil.cpp",
    "upstream/folly/detail/Futex.cpp",
    "upstream/folly/GroupVarint.cpp",
    "upstream/folly/IPAddress.cpp",
    "upstream/folly/IPAddressV4.cpp",
    "upstream/folly/IPAddressV6.cpp",
    "upstream/folly/LifoSem.cpp",
    "upstream/folly/io/Compression.cpp",
    "upstream/folly/io/IOBuf.cpp",
    "upstream/folly/io/IOBufQueue.cpp",
    # These require libevent
    # "upstream/folly/io/async/AsyncTimeout.cpp",
    # "upstream/folly/io/async/EventBase.cpp",
    # "upstream/folly/io/async/EventHandler.cpp",
    # "upstream/folly/io/async/Request.cpp",
    "upstream/folly/json.cpp",
    "upstream/folly/detail/MemoryIdler.cpp",
    "upstream/folly/MacAddress.cpp",
    "upstream/folly/Random.cpp",
    "upstream/folly/SafeAssert.cpp",
    "upstream/folly/SpookyHashV1.cpp",
    "upstream/folly/SpookyHashV2.cpp",
    "upstream/folly/stats/Instantiations.cpp",
    "upstream/folly/Subprocess.cpp",
    "upstream/folly/ThreadCachedArena.cpp",
    "upstream/folly/TimeoutQueue.cpp",
    "upstream/folly/Uri.cpp",
    # "upstream/folly/wangle/InlineExecutor.cpp",
    # "upstream/folly/wangle/ManualExecutor.cpp",
    # "upstream/folly/wangle/ThreadGate.cpp",
  ],
  deps = [
    ":base",
    "//third_party/double-conversion",
    "//third_party/re2",
    "//third_party/glog",
    "//third_party/gflags",
    # "//third_party/libevent:libevent",
  ],
  linkopts = [
    "-ldl",
  ],
)

cc_library(
  name = "recordio",
  visibility = ["//visibility:public"],
  hdrs = [
  ],
  srcs = [
    "upstream/folly/io/RecordIO.cpp",
    "upstream/folly/MemoryMapping.cpp",
    "upstream/folly/experimental/io/FsUtil.cpp",
    "upstream/folly/experimental/io/HugePages.cpp",
  ],
  deps = [
    ":folly",
  ],
)

# Test libraries and tests.
cc_library(
  name = "testutil",
  visibility = ["//visibility:public"],
  hdrs = [
  ],
  srcs = [
    "upstream/folly/experimental/TestUtil.cpp",
  ],
  deps = [
    ":base",
  ],
  testonly = 1
)

cc_library(
  name = "benchmark",
  visibility = ["//visibility:public"],
  hdrs = [
    "upstream/folly/Benchmark.h",
  ],
  srcs = [
    "upstream/folly/Benchmark.cpp",
  ],
  deps = [
    ":folly",
  ],
  testonly = 1
)
