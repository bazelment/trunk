licenses(['notice'])
package(default_visibility = ['//visibility:public'])

icu_copts = [
    '-fno-exceptions',
    '-I' + PACKAGE_NAME + '/svn/common',
    '-I' + PACKAGE_NAME + '/svn/i18n',
    '-I' + PACKAGE_NAME + '/svn/io',
    '-I' + PACKAGE_NAME + '/svn/tools/ctestfw',
    '-I' + PACKAGE_NAME + '/svn/tools/toolutil',
]

icu_linkopts = [
    '-ldl',
]

cc_library(
    visibility = ['//visibility:__pkg__'],
    name = 'icu-base',
    srcs = glob([
        'svn/common/**/*.c',
        'svn/common/**/*.cpp',
        'svn/io/**/*.c',
        'svn/io/**/*.cpp',
        'svn/i18n/**/*.c',
        'svn/i18n/**/*.cpp',
        # Including the layoutex directory leads to the following error:
        #       third_party/icu/layoutex/LXUtilities.cpp:10:28: \
        #           fatal error: layout/LETypes.h: No such file or directory
        #        #include "layout/LETypes.h"
        #'layoutex/**/*.c',
        #'layoutex/**/*.cpp',
    ]),
    hdrs = glob([
        'svn/common/**/*.h',
        'svn/io/**/*.h',
        'svn/i18n/**/*.h',
        #'layoutex/**/*.h',
    ]),
    defines = [
        # Officially recommended settings.
        'U_USING_ICU_NAMESPACE=0',
        'U_CHARSET_IS_UTF8=1',
        'U_NO_DEFAULT_INCLUDE_UTF_HEADERS=1',

        # Without -DU_HAVE_ELF_H=1, the tools/toolutil/pkg_genc.c will not
        # export the symbol 'writeObjectCode'.  Discovered via `VERBOSE=1 make`.
        'U_HAVE_ELF_H=1',
        '_REENRANT=1',
        'U_HAVE_STRTOD_L=1',

        # TODO: The following macros are recommended by the official
        # install guide.  Unfortunately, they break the tests shipped
        # with the source code.  Commented out for now.
        ## add `explicit` to ctors
        #'UNISTR_FROM_CHAR_EXPLICIT=explicit',
        ## add `explicit` to ctors
        #'UNISTR_FROM_STRING_EXPLICIT=explicit',
    ],
    copts = icu_copts + [
        # required for building the files under common/
        '-DU_COMMON_IMPLEMENTATION',
        # required for building the files under io/
        '-DU_IO_IMPLEMENTATION',
        # required for building the files under i18n/
        '-DU_I18N_IMPLEMENTATION',
    ],
)

cc_library(
    visibility = ["//visibility:__pkg__"],
    name = 'stubdata',
    srcs = [
        'svn/stubdata/stubdata.c',
    ],
    deps = [
        ':icu-base',
    ],
    copts = icu_copts,
)

cc_library(
    visibility = ["//visibility:__pkg__"],
    name = 'icu-tools',
    srcs = glob([
        'svn/tools/ctestfw/**/*.c',
        'svn/tools/ctestfw/**/*.cpp',
        'svn/tools/toolutil/**/*.c',
        'svn/tools/toolutil/**/*.cpp',
    ]),
    hdrs = glob([
        'svn/tools/ctestfw/**/*.h',
        'svn/tools/toolutil/**/*.h',
    ]),
    deps = [
        'icu-base',
    ],
    copts = icu_copts + [
        '-DU_TOOLUTIL_IMPLEMENTATION',
    ]
)

# The complete list of tools is:
#
#     derb     genccode   gencmn     gendict    genrb      icupkg     pkgdata
#     genbrk   gencfu     gencnval   gennorm2   gensprep   makeconv   uconv
#
# Only build icupkg and pkgdata here as they are needed for building libicudata.
#
# TODO: There is a bug in bazel that prevents the above tools to be built.  The
# problem is that cc_binary treats :stubdata as a separate library.  As a
# result, at linking time, the object file stubdata.pic.o separated from other
# object files by pairs of `--start-lib` and `--end-lib`, which prevents other
# object files from seeing stubdata.pic.o directly, thus leading to the
# following error:
#       error: undefined reference to 'icudt58_dat'
# There is a workaround to the above described problem.  That is, just build the
# :libicudata target, which depends on :icupkg and :pkgdata.  After `bazel build
# :libicudata`, you can find the `icupkg` and `pkgdata` binaries in
# bazel-bin/third_party/icu/.

cc_binary(
    name = 'icupkg',
    srcs = [
        'svn/tools/icupkg/icupkg.cpp',
    ],
    deps = [
        ':icu-tools',
        ':stubdata',
    ],
    copts = icu_copts,
    linkopts = icu_linkopts,
)

cc_binary(
    name = 'makeconv',
    srcs = glob([
        'svn/tools/makeconv/*.c',
        'svn/tools/makeconv/*.cpp',
        'svn/tools/makeconv/*.h',
    ]),
    deps = [
        ':icu-tools',
        ':stubdata',
    ],
    copts = icu_copts,
    linkopts = icu_linkopts,
)

cc_binary(
    name = 'pkgdata',
    srcs = [
        'svn/tools/pkgdata/pkgdata.cpp',
        'svn/tools/pkgdata/pkgtypes.c',
        'svn/tools/pkgdata/pkgtypes.h',
    ],
    deps = [
        ':icu-tools',
        ':stubdata',
    ],
    copts = icu_copts,
    linkopts = icu_linkopts,
)

genrule(
    visibility = ['//visibility:__pkg__'],
    name = 'libicudata',
    srcs = [
        'svn/data/in/icudt58l.dat',
        # TODO: Unfortunately, the icupkg.inc.x86_64 is not bazelised yet.  Read
        # the comments at the top of the file to see how to generate this file
        # from icu source and get an idea about how to bazelise it.
        'icupkg.inc.x86_64',
    ],
    tools = [
        ':icupkg',
        ':pkgdata',
    ],
    outs = [
        'libicudata.a',
        'libicudata.so',
    ],
    cmd = 'true' + \
        # The 'out' dircectory is a temporary directory.
        ' && mkdir -p out' + \
        ' && mkdir -p out/build' + \
        ' && mkdir -p out/build/icudt58l' + \
        ' && mkdir -p out/build/icudt58l/curr' + \
        ' && mkdir -p out/build/icudt58l/lang' + \
        ' && mkdir -p out/build/icudt58l/region' + \
        ' && mkdir -p out/build/icudt58l/zone' + \
        ' && mkdir -p out/build/icudt58l/unit' + \
        ' && mkdir -p out/build/icudt58l/brkitr' + \
        ' && mkdir -p out/build/icudt58l/coll' + \
        ' && mkdir -p out/build/icudt58l/rbnf' + \
        ' && mkdir -p out/build/icudt58l/translit' + \
        ' && mkdir -p out/tmp' + \
        ' && mkdir -p out/tmp/curr' + \
        ' && mkdir -p out/tmp/lang' + \
        ' && mkdir -p out/tmp/region' + \
        ' && mkdir -p out/tmp/zone' + \
        ' && mkdir -p out/tmp/unit' + \
        ' && mkdir -p out/tmp/coll' + \
        ' && mkdir -p out/tmp/rbnf' + \
        ' && mkdir -p out/tmp/translit' + \
        ' && mkdir -p out/tmp/brkitr' + \
        ' && $(location :icupkg) -d out/build/icudt58l --list -x \* $(location svn/data/in/icudt58l.dat) -o out/tmp/icudata.lst' + \
        ' && $(location :pkgdata) -O $(location icupkg.inc.x86_64) -q -c -s out/build/icudt58l -d out -e icudt58  -T out/tmp -p icudt58l -m static -r 58.2 -L icudata out/tmp/icudata.lst &> /dev/null' + \
        ' && cp out/libicudata.a $(location libicudata.a)' + \
        ' && $(location :pkgdata) -O $(location icupkg.inc.x86_64) -q -c -s out/build/icudt58l -d out -e icudt58  -T out/tmp -p icudt58l -m dll -r 58.2 -L icudata out/tmp/icudata.lst &> /dev/null' + \
        ' && cp -H out/libicudata.so $(location libicudata.so)' + \
        ' && rm -rf out' + \
        '',
)

cc_library(
    name = 'icu-data',
    srcs = [
        'libicudata.a',
        'libicudata.so',
    ],
)

cc_library(
    name = 'icu',
    deps = [
        ':icu-base',
        ':icu-data',
    ],
    copts = icu_copts,
)

# TODO: Running this binary without any arguments would fail the last three
# tests.  To fix that, need to build the data file used by those last three
# tests and link against this binary.
cc_binary(
    name = 'iotest',
    srcs = glob([
        'svn/test/iotest/*.c',
        'svn/test/iotest/*.cpp',
        'svn/test/iotest/*.h',
    ]),
    deps = [
        ':icu-tools',
        ':icu-data',
    ],
    copts = icu_copts,
    linkopts = icu_linkopts,
)
