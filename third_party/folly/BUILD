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
    "upstream/folly/detail/FingerprintPolynomial.h",
  ],
  deps = [
    ":base",
    "//external:gflags",
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
    "linux-k8/folly/folly-config.h",
    "upstream/folly/ApplyTuple.h",
    "upstream/folly/CPortability.h",
    "upstream/folly/Conv.h",
    "upstream/folly/CpuId.h",
    "upstream/folly/Demangle.h",
    "upstream/folly/Exception.h",
    "upstream/folly/ExceptionWrapper.h",
    "upstream/folly/detail/ExceptionWrapper.h",
    "upstream/folly/FBString.h",
    "upstream/folly/FBVector.h",
    "upstream/folly/Fingerprint.h",
    "upstream/folly/Format-inl.h",
    "upstream/folly/Format.h",
    "upstream/folly/FormatArg.h",
    "upstream/folly/FormatTraits.h",
    "upstream/folly/Hash.h",
    "upstream/folly/Likely.h",
    "upstream/folly/Malloc.h",
    "upstream/folly/MoveWrapper.h",
    "upstream/folly/Portability.h",
    "upstream/folly/portability/Syscall.h",
    "upstream/folly/Preprocessor.h",
    "upstream/folly/ProducerConsumerQueue.h",
    "upstream/folly/Range.h",
    "upstream/folly/ScopeGuard.h",
    "upstream/folly/SpookyHashV1.h",
    "upstream/folly/SpookyHashV2.h",
    "upstream/folly/String-inl.h",
    "upstream/folly/String.h",
    "upstream/folly/ThreadName.h",
    "upstream/folly/Traits.h",
    "upstream/folly/Unicode.h",
    "upstream/folly/experimental/io/FsUtil.h",
  ],
  srcs = [
    ":generate_format_tables",
    ":generate_escape_tables",
    "upstream/folly/detail/Malloc.h",
    "upstream/folly/detail/RangeCommon.h",
    "upstream/folly/detail/RangeSse42.h",
    "upstream/folly/detail/UncaughtExceptionCounter.h",
    "upstream/folly/Conv.cpp",
    "upstream/folly/Demangle.cpp",
    "upstream/folly/Format.cpp",
    "upstream/folly/StringBase.cpp",
    "upstream/folly/String.cpp",
    "upstream/folly/SpookyHashV1.cpp",
    "upstream/folly/SpookyHashV2.cpp",
    "upstream/folly/Unicode.cpp",
  ],
  deps = [
    "//external:glog",
    "//external:gflags",
    "//third_party/double-conversion",
    "//third_party/boost:config",
    "//third_party/boost:conversion",
    "//third_party/boost:iterator",
    "//third_party/boost:regex",
    "//third_party/boost:type_traits",
    "//third_party/boost:utility",
  ],
)

cc_library(
  name = "FingerprintTables",
  hdrs = [
    "upstream/folly/detail/FingerprintPolynomial.h",
  ],
  srcs = [
    ":generate_fingerprint_tables"
  ],
  deps = [
    ":base",
  ],
)

# cc_library(
#   name = "checksum",
#   visibility = ["//visibility:public"],
#   hdrs = [
#     "upstream/folly/Checksum.h"
#   ],
#   srcs = [
#     "upstream/folly/Checksum.cpp",
#   ],
#   deps = [
#     ":base",
#     "//third_party/boost:crc",
#   ],
# )

cc_library(
  name = "folly",
  visibility = ["//visibility:public"],
  hdrs = glob([
    "upstream/folly/stats/*.h",
    "upstream/folly/gen/*.h",
    "upstream/folly/*.h",
    "upstream/folly/detail/*.h",
  ]) + [
    "upstream/folly/experimental/ReadMostlySharedPtr.h",
    "upstream/folly/experimental/TLRefCount.h",
    "upstream/folly/io/Compression.h",
    "upstream/folly/io/Cursor.h",
    "upstream/folly/io/IOBuf.h",
    "upstream/folly/io/IOBufQueue.h",
    "upstream/folly/io/ShutdownSocketSet.h",
    "upstream/folly/io/async/Request.h",
  ],
  copts = [
    "-pthread",
  ],
  srcs = glob([
    "upstream/folly/detail/*.h",
  ]) + [
    ":generate_varint_tables",
    "upstream/folly/Bits.cpp",
    "upstream/folly/File.cpp",
    "upstream/folly/FileUtil.cpp",
    "upstream/folly/GroupVarint.cpp",
    "upstream/folly/IPAddress.cpp",
    "upstream/folly/IPAddressV4.cpp",
    "upstream/folly/IPAddressV6.cpp",
    "upstream/folly/LifoSem.cpp",
    "upstream/folly/detail/CacheLocality.cpp",
    "upstream/folly/detail/Futex.cpp",
    "upstream/folly/dynamic.cpp",
    "upstream/folly/io/Compression.cpp",
    "upstream/folly/io/IOBuf.cpp",
    "upstream/folly/io/IOBufQueue.cpp",
    "upstream/folly/io/ShutdownSocketSet.cpp",
    "upstream/folly/SharedMutex.cpp",
    "upstream/folly/detail/ThreadLocalDetail.cpp",
    # These require libevent
    "upstream/folly/MacAddress.cpp",
    "upstream/folly/Random.cpp",
    "upstream/folly/SafeAssert.cpp",
    "upstream/folly/Singleton.cpp",
    "upstream/folly/SocketAddress.cpp",
    "upstream/folly/Subprocess.cpp",
    "upstream/folly/ThreadCachedArena.cpp",
    "upstream/folly/TimeoutQueue.cpp",
    "upstream/folly/Uri.cpp",
    "upstream/folly/detail/MemoryIdler.cpp",
    "upstream/folly/json.cpp",
    "upstream/folly/stats/Instantiations.cpp",
  ],
  deps = [
    ":base",
    "//third_party/double-conversion",
    "//external:glog",
    "//third_party/gflags",
    # "//third_party/libevent:libevent",
    "//third_party/boost:algorithm",  # For boost/non_copyable
    "//third_party/boost:core",  # For boost/non_copyable
    "//third_party/boost:container",
    "//third_party/boost:intrusive",
    "//third_party/boost:iterator",
    "//third_party/boost:multi_index",
    "//third_party/boost:regex",
    "//third_party/boost:thread",
    "//third_party/boost:utility",  # For boost/operators.hpp
  ],
  linkopts = [
    "-ldl",
  ],
)

cc_library(
  name = "async",
  visibility = ["//visibility:public"],
  srcs = [
    "upstream/folly/io/async/AsyncSignalHandler.cpp",
    "upstream/folly/io/async/AsyncSocket.cpp",
    "upstream/folly/io/async/AsyncServerSocket.cpp",
    "upstream/folly/io/async/AsyncUDPSocket.cpp",
    "upstream/folly/io/async/AsyncTimeout.cpp",
    "upstream/folly/io/async/EventBase.cpp",
    "upstream/folly/io/async/EventBaseManager.cpp",
    "upstream/folly/io/async/EventHandler.cpp",
    "upstream/folly/io/async/HHWheelTimer.cpp",
  ],
  hdrs = glob([
    "upstream/folly/io/async/*.h",
  ]) + [
    "upstream/folly/experimental/ExecutionObserver.h",
    "upstream/folly/futures/DrivableExecutor.h",
  ],
  defines = [
    "FOLLY_HAVE_VLA=0",
  ],
  deps = [
    ":folly",
    "//external:libssl",
    "//third_party/libevent",
    "//third_party/boost:iterator",
  ]
)

cc_library(
  name = "futures",
  visibility = ["//visibility:public"],
  srcs = glob([
    "upstream/folly/futures/*.cpp",
    "upstream/folly/futures/detail/*.cpp",
    "upstream/folly/experimental/fibers/*.cpp",
  ]),
  hdrs = glob([
    "upstream/folly/futures/*.h",
    "upstream/folly/futures/detail/*.h",
    "upstream/folly/experimental/fibers/*.h",
  ]),
  deps = [
    ":async",
    ":folly",
    "//third_party/boost:context",
  ]
)

cc_library(
  name = "ssl",
  visibility = ["//visibility:public"],
  hdrs = [
    "upstream/folly/io/async/AsyncSSLSocket.h",
    "upstream/folly/io/async/SSLContext.h",
  ],
  srcs = [
    "upstream/folly/io/async/AsyncSSLSocket.cpp",
    "upstream/folly/io/async/SSLContext.cpp",
  ],
  defines = [
    "FOLLY_HAVE_VLA=0",
  ],
  deps = [
    ":async",
    "//external:libssl",
  ]
)

# Broken because missing dwarf.h
#
# cc_library(
#   name = "symbolizer",
#   visibility = ["//visibility:public"],
#   hdrs = glob([
#     "upstream/folly/experimental/symbolizer/*.h",
#   ]),
#   srcs = glob([
#     "upstream/folly/experimental/symbolizer/*.cpp",
#   ]),
#   copts = [
#     #'-DHAVE_LINK_H=1'
#   ],
#   deps = [
#     ":base",
#     ":folly",
#     "//third_party/boost:assert",
#     "//third_party/boost:container",
#     "//third_party/boost:functional",
#     "//third_party/boost:iterator",
#     "//third_party/boost:intrusive",
#     "//third_party/boost:throw_exception",
#     "//third_party/boost:type_index",
#     "//third_party/boost:variant",
#   ],
# )

cc_library(
  name = "recordio",
  visibility = ["//visibility:public"],
  hdrs = [
    "upstream/folly/io/RecordIO.h",
    "upstream/folly/io/RecordIO-inl.h",
    "upstream/folly/MemoryMapping.h",
    "upstream/folly/experimental/io/FsUtil.h",
    "upstream/folly/experimental/io/HugePages.h",
  ],
  srcs = [
    "upstream/folly/io/RecordIO.cpp",
    "upstream/folly/MemoryMapping.cpp",
    "upstream/folly/experimental/io/FsUtil.cpp",
    "upstream/folly/experimental/io/HugePages.cpp",
  ],
  deps = [
    ":folly",
    "//third_party/boost:filesystem",
  ],
)

# Test libraries and tests.
cc_library(
  name = "testutil",
  visibility = ["//visibility:public"],
  hdrs = [
    "upstream/folly/experimental/TestUtil.h",
  ],
  srcs = [
    "upstream/folly/experimental/TestUtil.cpp",
  ],
  deps = [
    ":base",
    ":folly",
    "//third_party/boost:filesystem",
    "//third_party/boost:regex",
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
    "//third_party/boost:function_types",
    "//third_party/boost:regex",
  ],
  testonly = 1
)

cc_test(
  name = "AsciiCaseInsensitiveTest",
  srcs = [
    "upstream/folly/test/AsciiCaseInsensitiveTest.cpp"
  ],
  deps = [
    ":base",
    "//third_party/gflags",
    "//external:gtest",
  ]
)

# cc_test(
#   name = "ChecksumTest",
#   srcs = [
#     "upstream/folly/test/ChecksumTest.cpp"
#   ],
#   deps = [
#     ":checksum",
#     ":benchmark",
#     "//third_party/gflags",
#     "//external:gtest",
#   ]
# )

cc_test(
  name = "ProducerConsumerQueueTest",
  srcs = [
    "upstream/folly/test/ProducerConsumerQueueTest.cpp"
  ],
  deps = [
    ":base",
    "//third_party/boost:core",
    "//external:gtest_main",
  ]
)

cc_test(
  name = "StringTest",
  srcs = [
    "upstream/folly/test/StringTest.cpp"
  ],
  deps = [
    ":base",
    ":benchmark",
    "//third_party/gflags",
    "//external:gtest_main",
  ]
)

cc_binary(
  name = "subprocess_test_parent_death_helper",
  srcs = [
    "upstream/folly/test/SubprocessTestParentDeathHelper.cpp"
  ],
  deps = [
    ":folly",
    ":recordio",
    "//third_party/gflags",
  ],
  testonly = 1,
)

cc_test(
  name = "SubprocessTest",
  srcs = [
    "upstream/folly/test/SubprocessTest.cpp"
  ],
  deps = [
    ":folly",
    ":benchmark",
    ":recordio",
    ":testutil",
    "//third_party/gflags",
    "//external:gtest_main",
  ],
  data = [
    ":subprocess_test_parent_death_helper",
  ]
)

cc_test(
  name = "UriTest",
  srcs = [
    "upstream/folly/test/UriTest.cpp"
  ],
  deps = [
    ":folly",
    ":benchmark",
    "//third_party/gflags",
    "//external:gtest",
  ]
)

cc_test(
  name = "VarintTest",
  srcs = [
    "upstream/folly/test/VarintTest.cpp"
  ],
  deps = [
    ":folly",
    ":benchmark",
    "//third_party/gflags",
    "//external:gtest",
  ]
)
