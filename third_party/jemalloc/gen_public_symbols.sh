#!/bin/bash

# produce public_symbols.txt, see configure.ac
# this will be used public_namespace.sh and public_unnamespace.sh

# TODO: this should be auto updated.
jemalloc_version_gid="ac5185f73e4dc6b8d9a48b7080d07b11ef231765"

public_syms="aligned_alloc calloc dallocx free mallctl mallctlbymib
mallctlnametomib malloc malloc_conf malloc_message malloc_stats_print
malloc_usable_size mallocx smallocx_${jemalloc_version_gid} nallocx
posix_memalign rallocx realloc sallocx sdallocx xallocx"

public_syms="${public_syms} memalign valloc"

f=$1
cp /dev/null "${f}"
for nm in `echo ${mangling_map} |tr ',' ' '` ; do
    n=`echo ${nm} |tr ':' ' ' |awk '{print $[]1}'`
    m=`echo ${nm} |tr ':' ' ' |awk '{print $[]2}'`
    echo "${n}:${m}" >> "${f}"
    # Remove name from public_syms so that it isn't redefined later.
    public_syms=`for sym in ${public_syms}; do echo "${sym}"; done |grep -v "^${n}\$" |tr '\n' ' '`
done
for sym in ${public_syms} ; do
    n="${sym}"
    m="${JEMALLOC_PREFIX}${sym}"
    echo "${n}:${m}" >> "${f}"
done

