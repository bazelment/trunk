#!/bin/bash -ex
MAIN_SCRIPT=$1
export BINDIR=third_party/gperftools
export PPROF_PATH=third_party/gperftools/upstream/src/pprof
# For sampling test.
export TCMALLOC_SAMPLE_PARAMETER=524288
third_party/gperftools/upstream/src/tests/${MAIN_SCRIPT}
