licenses(['notice'])
package(default_visibility = ['//visibility:public'])

icu_copts = [
    '-Ithird_party/icu/github/source/common',
    '-Ithird_party/icu/github/source/i18n',
    '-Ithird_party/icu/github/source/io',
    '-Ithird_party/icu/github/source/tools/ctestfw',
    '-Ithird_party/icu/github/source/tools/toolutil',
]

icu_linkopts = [
    '-ldl',
]

cc_test(
    name = 'test_icu',
    srcs = [
        'test_icu.cpp',
    ],
    deps = [
        '//third_party/icu:icu',
    ],
    linkstatic = 1,
    copts = icu_copts,
    linkopts = icu_linkopts,
)

cc_test(
    name = 'test_UnicodeString',
    srcs = [
        'gtest_UnicodeString.cpp',
    ],
    deps = [
        '//third_party/gflags:gflags',
        '//third_party/gtest:gtest_main',
        '//third_party/icu:icu',
    ],
    linkstatic = 1,
    copts = icu_copts,
    linkopts = icu_linkopts,
)
