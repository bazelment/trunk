licenses(['notice'])
package(default_visibility = ['//visibility:public'])

icu_copts = [
    '-Ithird_party/icu/svn/common',
    '-Ithird_party/icu/svn/i18n',
    '-Ithird_party/icu/svn/io',
    '-Ithird_party/icu/svn/tools/ctestfw',
    '-Ithird_party/icu/svn/tools/toolutil',
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
