#include <stdio.h>

// This file demonstrates the usage of tcmalloc heapchecker to detect
// memory leak.
//
// bazel build examples/asan:leak
//
// export PPROF_PATH=...path_to...third_party/gperftools/upstream/src/pprof
// HEAPCHECK=strict bazel-bin/examples/asan/leak
//
// You should see leak report like this:
//
// Leak of 40 bytes in 1 objects allocated from:
//	@ 403cc8 main
//	@ 7fb9999937b0 __libc_start_main
int main() {
  int* a = new int[10];
  a[0] = 1;
  return 0;
}
