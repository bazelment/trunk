licenses(["notice"])

config_setting(
  name = "linux_x32",
  values = {"cpu": "piii"},
)

config_setting(
  name = "linux_x64",
  values = {"cpu": "k8"},
)

config_setting(
  name = "linux_arm",
  values = {"cpu": "arm"},
)

openssl_copts = [
  '-DOPENSSL_THREADS',
  '-D_REENTRANT',
  '-Wa,--noexecstack',
  '-DL_ENDIAN',
  '-O3',
  '-Wall',
  '-DOPENSSL_IA32_SSE2',
  '-DOPENSSL_BN_ASM_MONT',
  '-DOPENSSL_BN_ASM_MONT5',
  '-DOPENSSL_BN_ASM_GF2m',
  '-DSHA1_ASM ',
  '-DSHA256_ASM',
  '-DSHA512_ASM',
  '-DMD5_ASM',
  '-DAES_ASM',
  '-DVPAES_ASM',
  '-DBSAES_ASM',
  '-DWHIRLPOOL_ASM',
  '-DGHASH_ASM',
  '-DECP_NISTZ256_ASM',
  '-I' + package_name() + '/src/crypto',
  '-I' + package_name() + '/src/crypto/asn1',
  '-I' + package_name() + '/src/crypto/cmac',
  '-I' + package_name() + '/src/crypto/evp',
  '-I' + package_name() + '/src/crypto/modes',
  '-I' + package_name() + '/src',
]

load(':BUILD.generated.bzl', 'ssl_headers', 'ssl_internal_headers', 'ssl_sources',
     'crypto_headers', 'crypto_internal_headers', 'crypto_sources',
     'crypto_sources_linux_x86_64')

genrule(
  name = 'buildinfo',
  srcs = [
    'src/util/mkbuildinf.pl',
  ],
  outs = [
    # The output directory has to match our include path
    'linux-x86_64/include/buildinf.h',
  ],
  cmd = '/usr/bin/perl $< "' + ' '.join(openssl_copts) + '" "linux-x86_64" > $@'
)

cc_library(
  name = 'crypto',
  visibility = ["//visibility:public"],
  hdrs = crypto_headers + [
    ':buildinfo'
  ],
  srcs = crypto_internal_headers + crypto_sources + select({
    ":linux_x64": crypto_sources_linux_x86_64,
    "//conditions:default": crypto_sources_linux_x86_64,
  }),
  textual_hdrs = [
    "src/crypto/LPdir_unix.c",
    "src/crypto/ec/ecp_nistz256_table.c",
    "src/crypto/des/ncbc_enc.c",
  ],
  defines = [
    'OPENSSL_NO_STATIC_ENGINE',
  ],
  includes = [
    'linux-x86_64/include',
  ],
  copts = openssl_copts,
  linkopts = [
    '-pthread'
  ]
)

cc_library(
  name = 'ssl',
  visibility = ["//visibility:public"],
  hdrs = ssl_headers,
  srcs = ssl_internal_headers + ssl_sources,
  copts = openssl_copts,
  linkopts = [
    '-pthread'
  ],
  deps = [
    ':crypto',
  ]
)
