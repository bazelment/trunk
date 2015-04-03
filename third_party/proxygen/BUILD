licenses(["notice"])

# proxygen/lib/utils
genrule(
  name = "gen_trace_event_constants",
  srcs = [
    "upstream/proxygen/lib/utils/gen_trace_event_constants.py",
    "upstream/proxygen/lib/utils/TraceEventType.txt",
    "upstream/proxygen/lib/utils/TraceFieldType.txt",
  ],
  cmd = "mkdir -p $(GENDIR)/third_party/proxygen/trace && " +
    "python $(location upstream/proxygen/lib/utils/gen_trace_event_constants.py) " +
    "--output_type=cpp " +
    "--input_files=upstream/proxygen/lib/utils/TraceEventType.txt,upstream/proxygen/lib/utils/TraceFieldType.txt " +
    "--output_scope=proxygen " +
    "--header_path=proxygen/lib/utils " +
    "--fbcode_dir=. " + 
    "--install_dir=$(GENDIR)/third_party/proxygen/trace/proxygen/lib/utils",
  outs = [
    "trace/proxygen/lib/utils/TraceEventType.h",
    "trace/proxygen/lib/utils/TraceEventType.cpp",
    "trace/proxygen/lib/utils/TraceFieldType.h",
    "trace/proxygen/lib/utils/TraceFieldType.cpp",
  ]
)
  
cc_library(
  name = "utils",
  copts = [
    "-I$(GENDIR)/third_party/proxygen/trace",
  ],
  includes = [
    "upstream",
  ],
  srcs = glob(["upstream/proxygen/lib/utils/*.cpp"]) + [
    ":gen_trace_event_constants",
  ],
  deps = [
    "//third_party/folly",
    "//third_party/folly:async",
    "//third_party/boringssl",
  ],
)

cc_test(
  name = "parse_url_test",
  srcs = [
    "upstream/proxygen/lib/utils/test/ParseURLTest.cpp",
  ],
  deps = [
    "//third_party/gtest:gtest_main",
    ":utils"
  ]
)
