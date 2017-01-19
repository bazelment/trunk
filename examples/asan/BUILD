cc_binary(
  name = "use-after-free",
  srcs = [
    "use-after-free.cc"
  ],
)

cc_binary(
  name = "leak",
  srcs = [
    "leak.cc"
  ],
  testonly = 1,
  deps = [
    "//third_party/gperftools:tcmalloc_heapcheck",
  ],
)
