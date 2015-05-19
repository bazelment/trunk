licenses(["notice"])

AM_CXXFLAGS = [
  # Include the generated headers.
  "-Ithird_party/gperftools/linux-x86_64/src",
  # Include the source directory
  "-Ithird_party/gperftools/upstream/src",
  "-Wall",
  "-Wwrite-strings",
  "-Woverloaded-virtual",
  "-Wno-sign-compare",
  "-fno-builtin-malloc",
  "-fno-builtin-free",
  "-fno-builtin-realloc",
  "-fno-builtin-calloc",
  "-fno-builtin-cfree",
  "-fno-builtin-memalign",
  "-fno-builtin-posix_memalign",
  "-fno-builtin-valloc",
  "-fno-builtin-pvalloc",
  "-Wno-unused-result",
  "-fno-omit-frame-pointer",
]

cc_library(
  name = "logging",
  copts = AM_CXXFLAGS,
  hdrs = [
  ],
  srcs = [
    "upstream/src/base/logging.h",
    "upstream/src/base/commandlineflags.h",
    "upstream/src/base/basictypes.h",
    "upstream/src/base/dynamic_annotations.h",
    "upstream/src/third_party/valgrind.h",
    "upstream/src/base/logging.cc",
    "upstream/src/base/dynamic_annotations.c",
  ],
  deps = [
    ":sysinfo",
  ]
)

cc_library(
  name = "sysinfo",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/base/sysinfo.h",
    "upstream/src/getenv_safe.h",
    "upstream/src/base/cycleclock.h",
  ],
  srcs = [
    "upstream/src/base/arm_instruction_set_select.h",
    "upstream/src/base/sysinfo.cc",
  ]
)

cc_library(
  name = "spinlock",
  includes = [
    "src"
  ],
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/base/spinlock.h",
    "upstream/src/base/spinlock_internal.h",
    "upstream/src/base/spinlock_win32-inl.h",
    "upstream/src/base/spinlock_linux-inl.h",
    "upstream/src/base/spinlock_posix-inl.h",
    "upstream/src/base/synchronization_profiling.h",
    "upstream/src/base/atomicops-internals-macosx.h",
    "upstream/src/base/atomicops-internals-linuxppc.h",
    "upstream/src/base/atomicops-internals-arm-generic.h",
    "upstream/src/base/atomicops-internals-arm-v6plus.h",
    "upstream/src/base/atomicops-internals-mips.h",
    "upstream/src/base/atomicops-internals-windows.h",
    "upstream/src/base/atomicops-internals-gcc.h",
    "upstream/src/base/atomicops-internals-x86.h",
  ],
  srcs = [
    "upstream/src/base/spinlock.cc",
    "upstream/src/base/spinlock_internal.cc",
    "upstream/src/base/atomicops-internals-x86.cc",
  ],
  deps = [
    ":logging",
    ":sysinfo",
  ]
)

cc_library(
  name = "maybe_threads",
  copts = AM_CXXFLAGS,
  srcs = [
    "upstream/src/maybe_threads.cc"
  ]
)

cc_library(
  name = "raw_printer",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/raw_printer.h"
  ],
  srcs = [
    "upstream/src/raw_printer.cc"
  ]
)

cc_library(
  name = "stacktrace",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/gperftools/stacktrace.h",
  ],
  srcs = [
    "upstream/src/stacktrace_impl_setup-inl.h",
    "upstream/src/stacktrace_generic-inl.h",
    "upstream/src/stacktrace_libunwind-inl.h",
    "upstream/src/stacktrace_arm-inl.h",
    "upstream/src/stacktrace_powerpc-inl.h",
    "upstream/src/stacktrace_powerpc-darwin-inl.h",
    "upstream/src/stacktrace_powerpc-linux-inl.h",
    "upstream/src/stacktrace_x86-inl.h",
    "upstream/src/stacktrace_win32-inl.h",
    "upstream/src/stacktrace_instrument-inl.h",
    "upstream/src/base/elf_mem_image.h",
    "upstream/src/base/vdso_support.h",
    "upstream/src/stacktrace.cc",
    "upstream/src/base/elf_mem_image.cc",
    "upstream/src/base/vdso_support.cc",
  ],
  deps = [
    ":spinlock",
    "//third_party/libunwind:libunwind-k8",
  ]
)

TCMALLOC_CFLAGS = [
  "-pthread",
  "-DNDEBUG",
  # Certain tests require exception, so we didn't disable exception
  # completely.
  # "-fno-exceptions",
] + AM_CXXFLAGS

cc_library(
  name = "malloc_extension",
  hdrs = [
    "upstream/src/gperftools/malloc_extension.h",
    "upstream/src/gperftools/malloc_extension_c.h",
  ],
  copts = [
    "-DNO_HEAP_CHECK",
  ] + TCMALLOC_CFLAGS,
  srcs = [
    "upstream/src/malloc_extension.cc",
  ],
  deps = [
    ":maybe_threads"
  ]
)

cc_library(
  name = "malloc_extension_heapcheck",
  copts = TCMALLOC_CFLAGS,
  srcs = [
    "upstream/src/malloc_extension.cc",
  ],
  deps = [
    ":maybe_threads"
  ]
)

cc_library(
  name = "malloc_hook",
  copts = TCMALLOC_CFLAGS,
  hdrs = [
    "upstream/src/gperftools/malloc_hook.h",
    "upstream/src/gperftools/malloc_hook_c.h",
  ],
  srcs = [
  ],
  deps = [
    ":maybe_threads",
    ":spinlock"
  ]
)

cc_library(
  name = "profiler",
  visibility = ["//visibility:public"],
  copts = TCMALLOC_CFLAGS,
  hdrs = [
    "upstream/src/profiledata.h",
    "upstream/src/profile-handler.h",
  ],
  srcs = [
    "upstream/src/profiler.cc",
    "upstream/src/profile-handler.cc",
    "upstream/src/profiledata.cc",
  ],
  deps = [
    ":spinlock",
    ":logging",
  ]
)

cc_library(
  name = "internal",
  hdrs = [
  ],
  srcs = [
    "upstream/src/common.h",
    "upstream/src/internal_logging.h",
    "upstream/src/system-alloc.h",
    "upstream/src/packed-cache-inl.h",
    "upstream/src/tcmalloc_guard.h",
    "upstream/src/base/commandlineflags.h",
    "upstream/src/base/basictypes.h",
    "upstream/src/pagemap.h",
    "upstream/src/sampler.h",
    "upstream/src/central_freelist.h",
    "upstream/src/linked_list.h",
    "upstream/src/libc_override.h",
    "upstream/src/libc_override_gcc_and_weak.h",
    "upstream/src/libc_override_glibc.h",
    "upstream/src/libc_override_osx.h",
    "upstream/src/libc_override_redefine.h",
    "upstream/src/page_heap.h",
    "upstream/src/page_heap_allocator.h",
    "upstream/src/span.h",
    "upstream/src/static_vars.h",
    "upstream/src/symbolize.h",
    "upstream/src/thread_cache.h",
    "upstream/src/stack_trace_table.h",
    "upstream/src/base/thread_annotations.h",
    "upstream/src/common.cc",
    "upstream/src/internal_logging.cc",
    "upstream/src/memfs_malloc.cc",
    "upstream/src/central_freelist.cc",
    "upstream/src/page_heap.cc",
    "upstream/src/sampler.cc",
    "upstream/src/span.cc",
    "upstream/src/stack_trace_table.cc",
    "upstream/src/static_vars.cc",
    "upstream/src/symbolize.cc",
    "upstream/src/system-alloc.cc",
    "upstream/src/thread_cache.cc",
    # Others
  ],
  copts = TCMALLOC_CFLAGS,
  deps = [
    ":spinlock",
    ":maybe_threads",
    ":stacktrace",
  ],
  linkopts = [
    "-lm",
    "-pthread",
  ],
)

cc_library(
  name = "thread_lister",
  srcs = [
    "upstream/src/base/thread_lister.c",
    "upstream/src/base/linuxthreads.cc",
  ],
  copts = AM_CXXFLAGS,
)

HEAP_CHECKER_SRCS = [
  "upstream/src/heap-checker.cc",
  "upstream/src/heap-checker-bcad.cc"
]

# Malloc_hook contains some hidden symbols that are accessed by some
# other files, as well as tcmalloc.cc and debugallocation.cc, so these
# files need to compiled inside the same cc_library target.
#
# Otherwise we will see the linker would complain: relocation
# R_X86_64_PC32 against undefined hidden symbol
# `_ZN4base8internal10new_hooks_E' can not be used when making a
# shared object
MALLOC_HOOK_SRCS = [
  "upstream/src/malloc_hook.cc",
  "upstream/src/base/low_level_alloc.cc",
  "upstream/src/memory_region_map.cc",
  "upstream/src/heap-profile-table.cc",
  "upstream/src/heap-profiler.cc",
]

# thread-caching malloc
cc_library(
  name = "tcmalloc",
  visibility = ["//visibility:public"],
  srcs = [
    "upstream/src/tcmalloc.cc",
  ] + MALLOC_HOOK_SRCS,
  copts = TCMALLOC_CFLAGS,
  deps = [
    ":internal",
    ":malloc_hook",
    ":malloc_extension",
    ":raw_printer",
  ],
  alwayslink = 1,
)

# tcmalloc with heap checker
cc_library(
  name = "tcmalloc_heapcheck",
  visibility = ["//visibility:public"],
  srcs = [
    "upstream/src/tcmalloc.cc",
  ] + MALLOC_HOOK_SRCS + HEAP_CHECKER_SRCS,
  copts = TCMALLOC_CFLAGS,
  deps = [
    ":internal",
    ":malloc_hook",
    ":malloc_extension_heapcheck",
    ":thread_lister",
    ":raw_printer",
  ],
  testonly = 1,
  alwayslink = 1,
)

### ------- tcmalloc_debug (thread-caching malloc with debugallocation)
# Like tcmalloc.cc, debugallocation.cc needs exceptions to fulfill its
# API.  Luckily, we can reuse everything else from tcmalloc_minimal.
cc_library(
  name = "tcmalloc_debug",
  visibility = ["//visibility:public"],
  srcs = [
    "upstream/src/malloc_hook.cc",
    "upstream/src/debugallocation.cc",
  ],
  copts = TCMALLOC_CFLAGS + [
    "-DTCMALLOC_FOR_DEBUGALLOCATION",
  ],
  deps = [
    ":internal",
    ":malloc_hook",
    ":malloc_extension",
  ],
  alwayslink = 1,
)

cc_library(
  name = "tcmalloc_debug_heapcheck",
  visibility = ["//visibility:public"],
  srcs = [
    "upstream/src/debugallocation.cc",
  ] + MALLOC_HOOK_SRCS + HEAP_CHECKER_SRCS,
  copts = TCMALLOC_CFLAGS + [
    "-DTCMALLOC_FOR_DEBUGALLOCATION",
  ],
  deps = [
    ":internal",
    ":malloc_hook",
    ":malloc_extension_heapcheck",
    ":raw_printer",
    ":thread_lister",
  ],
  alwayslink = 1,
  testonly = 1,
)

# Test related stuff
# ==================
cc_library(
  name = "testutil",
  copts = AM_CXXFLAGS,
  testonly = 1,
  srcs = [
    "upstream/src/tests/testutil.h",
    "upstream/src/tests/testutil.cc",
  ],
)

cc_test(
  name = "addressmap_unittest",
  srcs = [
    "upstream/src/tests/addressmap_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":logging",
  ]
)

# cc_test(
#   name = "sampler_test",
#   srcs = [
#     "upstream/src/tests/sampler_test.cc",
#   ],
#   copts = AM_CXXFLAGS,
#   deps = [
#     ":internal",
#     ":malloc_extension",
#   ]
# )

cc_test(
  name = "stacktrace_unittest",
  srcs = [
    "upstream/src/tests/stacktrace_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":logging",
    ":stacktrace",
  ]
)

cc_test(
  name = "tcmalloc_unittest",
  srcs = [
    "upstream/src/tests/tcmalloc_unittest.cc",
  ],
  copts = ["-fno-builtin"] + AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ]
)

cc_test(
  name = "heap-checker_unittest",
  srcs = [
    "upstream/src/tests/heap-checker_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc_debug_heapcheck",
  ],
  linkstatic = 1,
)
