licenses(["notice"])

AM_CXXFLAGS = [
  # Include the generated headers.
  "-Ithird_party/gperftools/linux-x86_64/src",
  # Include the source directory
  "-Ithird_party/gperftools/upstream/src",
  "-Wall",
  "-Wwrite-strings",
  # "-Woverloaded-virtual",
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

# Config header plus some internal headers.
cc_library(
  name = "config_header",
  hdrs = [
    "linux-x86_64/src/config.h",
    "upstream/src/base/basictypes.h",
    "upstream/src/base/dynamic_annotations.h",
    "upstream/src/getenv_safe.h",
    "upstream/src/third_party/valgrind.h",
  ],
)

cc_library(
  name = "logging",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/addressmap-inl.h",
    "upstream/src/base/logging.h",
  ],
  srcs = [
    "upstream/src/base/commandlineflags.h",
    "upstream/src/base/logging.cc",
  ],
  deps = [
    ":config_header",
    ":sysinfo",
  ]
)

cc_library(
  name = "sysinfo",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/base/basictypes.h",
    "upstream/src/base/sysinfo.h",
    "upstream/src/base/cycleclock.h",
  ],
  srcs = [
    "upstream/src/base/logging.h",
    "upstream/src/base/commandlineflags.h",
    "upstream/src/base/arm_instruction_set_select.h",
    "upstream/src/base/dynamic_annotations.c",
    "upstream/src/base/sysinfo.cc",
  ],
  deps = [
    ":config_header",
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
    "upstream/src/base/atomicops.h",
    "upstream/src/base/googleinit.h",
    "upstream/src/base/linux_syscall_support.h",
    "upstream/src/base/thread_annotations.h",
  ],
  srcs = [
    "upstream/src/base/spinlock.cc",
    "upstream/src/base/spinlock_internal.cc",
    "upstream/src/base/atomicops-internals-x86.cc",
  ],
  deps = [
    ":logging",
    ":sysinfo",
  ],
)

cc_library(
  name = "maybe_threads",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/maybe_threads.h"
  ],
  srcs = [
    "upstream/src/maybe_threads.cc"
  ],
  deps = [
    ":config_header",
  ],

)

cc_library(
  name = "raw_printer",
  copts = AM_CXXFLAGS,
  hdrs = [
    "upstream/src/raw_printer.h"
  ],
  srcs = [
    "upstream/src/raw_printer.cc"
  ],
  deps = [
    ":logging",
    ":config_header",
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
  name = "profiler",
  visibility = ["//visibility:public"],
  copts = TCMALLOC_CFLAGS,
  hdrs = [
    "upstream/src/getpc.h",
    "upstream/src/gperftools/profiler.h",
    "upstream/src/profile-handler.h",
    "upstream/src/profiledata.h",
  ],
  srcs = [
    "upstream/src/profiler.cc",
    "upstream/src/profile-handler.cc",
    "upstream/src/profiledata.cc",
  ],
  deps = [
    ":maybe_threads",
    ":spinlock",
    ":stacktrace",
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
    "upstream/src/gperftools/malloc_extension.h",
    "upstream/src/page_heap_allocator.h",
    "upstream/src/span.h",
    "upstream/src/static_vars.h",
    "upstream/src/symbolize.h",
    "upstream/src/thread_cache.h",
    "upstream/src/stack_trace_table.h",
    "upstream/src/base/thread_annotations.h",
    "upstream/src/common.cc",
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
  linkstatic = 1,
)

cc_library(
  name = "thread_lister",
  hdrs = [
    "upstream/src/base/linux_syscall_support.h",
    "upstream/src/base/linuxthreads.h",
    "upstream/src/base/thread_lister.h",
  ],
  srcs = [
    "upstream/src/base/thread_lister.c",
    "upstream/src/base/linuxthreads.cc",
  ],
  deps = [
    ":config_header",
  ],
  copts = AM_CXXFLAGS,
)

HEAP_CHECKER_SRCS = [
  "upstream/src/gperftools/heap-checker.h",
  "upstream/src/heap-checker.cc",
  "upstream/src/heap-checker-bcad.cc",
  "upstream/src/base/elfcore.h",
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
  "upstream/src/base/low_level_alloc.cc",
  "upstream/src/base/low_level_alloc.h",
  "upstream/src/base/stl_allocator.h",
  "upstream/src/gperftools/heap-profiler.h",
  "upstream/src/gperftools/malloc_extension.h",
  "upstream/src/gperftools/malloc_extension_c.h",
  "upstream/src/gperftools/malloc_hook.h",
  "upstream/src/gperftools/malloc_hook_c.h",
  "upstream/src/heap-profile-stats.h",
  "upstream/src/heap-profile-table.cc",
  "upstream/src/heap-profile-table.h",
  "upstream/src/heap-profiler.cc",
  "upstream/src/internal_logging.cc",
  "upstream/src/malloc_extension.cc",
  "upstream/src/malloc_hook-inl.h",
  "upstream/src/malloc_hook.cc",
  "upstream/src/malloc_hook_mmap_linux.h",
  "upstream/src/memfs_malloc.cc",
  "upstream/src/memory_region_map.cc",
  "upstream/src/memory_region_map.h",
]

# thread-caching malloc
cc_library(
  name = "tcmalloc",
  visibility = ["//visibility:public"],
  deps = select({
    # tcmalloc is not compitable with asan/tsan/msan, so we remove it.
    "//tools/cpp:opt_enabled": [ ":tcmalloc_opt"],
    "//conditions:default": [":tcmalloc_debug"],
  })
)

cc_library(
  name = "tcmalloc_heapcheck",
  visibility = ["//visibility:public"],
  testonly = 1,
  deps = select({
    # tcmalloc is not compitable with asan/tsan/msan, so we remove it.
    "//tools/cpp:opt_enabled": [ ":tcmalloc_opt_heapcheck"],
    "//conditions:default": [":tcmalloc_debug_heapcheck"],
  })
)

# opt version
cc_library(
  name = "tcmalloc_opt",
  hdrs = [
    "linux-x86_64/src/gperftools/tcmalloc.h",
  ],
  srcs = [
    "upstream/src/tcmalloc.cc",
  ] + MALLOC_HOOK_SRCS,
  copts = TCMALLOC_CFLAGS + [
    "-DNO_HEAP_CHECK",
  ],
  deps = [
    ":internal",
    ":raw_printer",
  ],
  alwayslink = 1,
)

# tcmalloc with heap checker
cc_library(
  name = "tcmalloc_opt_heapcheck",
  hdrs = [
    "linux-x86_64/src/gperftools/tcmalloc.h",
  ],
  srcs = [
    "upstream/src/tcmalloc.cc",
  ] + MALLOC_HOOK_SRCS + HEAP_CHECKER_SRCS,
  copts = TCMALLOC_CFLAGS,
  deps = [
    ":internal",
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
  hdrs = [
    "linux-x86_64/src/gperftools/tcmalloc.h",
    "upstream/src/tcmalloc.cc",
  ],
  srcs = [
    "upstream/src/debugallocation.cc",

  ] +  MALLOC_HOOK_SRCS,
  copts = TCMALLOC_CFLAGS + [
    "-DNO_HEAP_CHECK",
    "-DTCMALLOC_FOR_DEBUGALLOCATION",
  ],
  deps = [
    ":internal",
    ":raw_printer",
  ],
  alwayslink = 1,
)

cc_library(
  name = "tcmalloc_debug_heapcheck",
  hdrs = [
    "linux-x86_64/src/gperftools/tcmalloc.h",
    "upstream/src/tcmalloc.cc",
  ],
  srcs = [
    "upstream/src/debugallocation.cc",
  ] + MALLOC_HOOK_SRCS + HEAP_CHECKER_SRCS,
  copts = TCMALLOC_CFLAGS + [
    "-DTCMALLOC_FOR_DEBUGALLOCATION",
  ],
  deps = [
    ":internal",
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
  hdrs = [
    "upstream/src/config_for_unittests.h",
  ],
  srcs = [
    "upstream/src/tests/testutil.h",
    "upstream/src/tests/testutil.cc",
  ],
  deps = [
    ":config_header",
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

cc_test(
  name = "atomicops_unittest",
  srcs = [
    "upstream/src/tests/atomicops_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":spinlock",
  ]
)

cc_test(
  name = "current_allocated_bytes_test",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/current_allocated_bytes_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ]
)

cc_test(
  name = "debugallocation_test",
  srcs = [
    "upstream/src/tests/debugallocation_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc_debug",
  ]
)

cc_test(
  name = "heap-checker_unittest",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/heap-checker_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc_heapcheck",
  ],
  linkstatic = 1,
  tags = [
    "no_travis", # Broken on travis
  ],
)

sh_test(
  name = "heap-checker_unittest_sh",
  srcs = [
    "runtest.sh",
  ],
  data = [
    "upstream/src/tests/heap-checker_unittest.sh",
    "upstream/src/pprof",
    ":heap-checker_unittest",
  ],
  args = [
    "heap-checker_unittest.sh",
  ],
  tags = [
    "no_travis", # Broken on travis
  ],
)

cc_test(
  name = "heap-profiler_unittest",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/heap-profiler_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ],
  linkstatic = 1,
)

sh_test(
  name = "heap-profiler_unittest_sh",
  srcs = [
    "runtest.sh",
  ],
  data = [
    "upstream/src/tests/heap-profiler_unittest.sh",
    "upstream/src/pprof",
    ":heap-profiler_unittest",
  ],
  args = [
    "heap-profiler_unittest.sh",
  ]
)

cc_test(
  name = "large_heap_fragmentation_unittest",
  srcs = [
    "upstream/src/tests/large_heap_fragmentation_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    # tcmalloc_debug is too slow to run this test.
    ":tcmalloc_opt",
  ],
)

cc_test(
  name = "low_level_alloc_unittest",
  srcs = [
    "upstream/src/tests/low_level_alloc_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ],
)

cc_test(
  name = "malloc_extension_c_test",
  srcs = [
    "upstream/src/tests/malloc_extension_c_test.c",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    # tcmalloc_debug may perform new operation inside free function,
    # that's not expected in this test.
    ":tcmalloc_opt",
  ],
)

cc_test(
  name = "malloc_extension_test",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/malloc_extension_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ],
)

cc_test(
  name = "malloc_hook_test",
  srcs = [
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/malloc_hook_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ],
)

cc_test(
  name = "markidle_unittest",
  srcs = [
    "upstream/src/tests/markidle_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ],
)

cc_test(
  name = "memalign_unittest",
  srcs = [
    "upstream/src/tcmalloc.h",
    "upstream/src/tests/memalign_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ],
)

cc_test(
  name = "packed-cache_test",
  srcs = [
    "upstream/src/tests/packed-cache_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ],
)

cc_test(
  name = "page_heap_test",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/page_heap_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ],
)

cc_test(
  name = "pagemap_unittest",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/pagemap_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ],
)

cc_test(
  name = "profiledata_unittest",
  srcs = [
    "upstream/src/tests/profiledata_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":profiler",
    ":tcmalloc",
  ],
)

cc_test(
  name = "profile-handler_unittest",
  srcs = [
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/profile-handler_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":profiler",
    ":tcmalloc",
  ],
)

# profiler1-4 are used by profiler_unittest_sh
cc_binary(
  name = "profiler1_unittest",
  srcs = [
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/profiler_unittest.cc",
  ],
  testonly = 1,
  copts = AM_CXXFLAGS + [
    "-g",
    "-DNO_THREADS",
  ],
  deps = [
    ":testutil",
    ":profiler",
    ":tcmalloc",
  ],
)

cc_binary(
  name = "profiler2_unittest",
  srcs = [
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/profiler_unittest.cc",
  ],
  testonly = 1,
  copts = AM_CXXFLAGS + [
    "-g",
    "-DNO_THREADS",
  ],
  deps = [
    ":testutil",
    ":profiler",
    ":tcmalloc",
  ],
)

cc_binary(
  name = "profiler3_unittest",
  srcs = [
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/profiler_unittest.cc",
  ],
  testonly = 1,
  copts = AM_CXXFLAGS + [
    "-g",
    "-pthread",
  ],
  deps = [
    ":testutil",
    ":profiler",
    ":tcmalloc",
  ],
)

cc_binary(
  name = "profiler4_unittest",
  srcs = [
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/profiler_unittest.cc",
  ],
  testonly = 1,
  copts = AM_CXXFLAGS + [
    "-g",
    "-pthread",
  ],
  deps = [
    ":testutil",
    ":profiler",
    ":tcmalloc",
  ],
)

sh_test(
  name = "profiler_unittest_sh",
  srcs = [
    "runtest.sh",
  ],
  data = [
    "upstream/src/tests/profiler_unittest.sh",
    "upstream/src/pprof",
    ":profiler1_unittest",
    ":profiler2_unittest",
    ":profiler3_unittest",
    ":profiler4_unittest",
  ],
  args = [
    "profiler_unittest.sh",
  ],
  tags = [
    "manual",  # Broken
  ],
)

cc_test(
  name = "raw_printer_test",
  srcs = [
    "upstream/src/tests/raw_printer_test.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ]
)

cc_test(
  name = "realloc_unittest",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/realloc_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ]
)

cc_test(
  name = "sampler_test",
  srcs = [
    "upstream/src/tests/sampler_test.cc",
    "upstream/src/config_for_unittests.h",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ]
)

cc_binary(
  name = "sampling_test",
  testonly = 1,
  srcs = [
    "upstream/src/tests/sampling_test.cc",
    "upstream/src/config_for_unittests.h",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ]
)

sh_test(
  name = "sampling_test_sh",
  srcs = [
    "runtest.sh",
  ],
  data = [
    "upstream/src/tests/sampling_test.sh",
    "upstream/src/pprof",
    ":sampling_test",
  ],
  args = [
    "sampling_test.sh",
  ]
)

cc_test(
  name = "simple_compat_test",
  srcs = glob([
    "upstream/src/google/*.h",
  ]) + [
    "upstream/src/gperftools/heap-checker.h",
    "upstream/src/gperftools/profiler.h",
    "upstream/src/tests/simple_compat_test.cc",
  ],
  copts = AM_CXXFLAGS,
  includes = [
    "upstream/src",
  ],
  deps = [
    ":tcmalloc",
  ]
)

cc_test(
  name = "stack_trace_table_test",
  srcs = [
    "upstream/src/tests/stack_trace_table_test.cc",
    "upstream/src/config_for_unittests.h",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ]
)

cc_test(
  name = "stacktrace_unittest",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/stacktrace_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":logging",
    ":stacktrace",
  ]
)

cc_test(
  name = "system-alloc_unittest",
  srcs = [
    "upstream/src/config_for_unittests.h",
    "upstream/src/tests/system-alloc_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":tcmalloc",
  ],
  linkstatic = 1,
)

cc_test(
  name = "tcmalloc_unittest",
  srcs = [
    "upstream/src/tcmalloc.h",
    "upstream/src/base/simple_mutex.h",
    "upstream/src/tests/tcmalloc_unittest.cc",
  ],
  copts = ["-fno-builtin"] + AM_CXXFLAGS,
  deps = [
    ":testutil",
    # tcmalloc_debug is doing something unexpected than the test(like
    # realloc)
    ":tcmalloc_opt",
  ],
  linkstatic = 1,
)

sh_test(
  name = "tcmalloc_unittest_sh",
  srcs = [
    "runtest.sh",
  ],
  data = [
    "upstream/src/tests/tcmalloc_unittest.sh",
    "upstream/src/pprof",
    ":tcmalloc_unittest",
  ],
  args = [
    "tcmalloc_unittest.sh",
  ]
)

cc_test(
  name = "tcmalloc_large_unittest",
  srcs = [
    "upstream/src/tests/tcmalloc_large_unittest.cc",
  ],
  copts = ["-fno-builtin"] + AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ],
  linkstatic = 1,
)

cc_test(
  name = "thread_dealloc_unittest",
  srcs = [
    "upstream/src/tests/thread_dealloc_unittest.cc",
  ],
  copts = AM_CXXFLAGS,
  deps = [
    ":testutil",
    ":tcmalloc",
  ]
)
