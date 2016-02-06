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
  '-I' + PACKAGE_NAME + '/src/crypto',
  '-I' + PACKAGE_NAME + '/src/crypto/asn1',
  '-I' + PACKAGE_NAME + '/src/crypto/cmac',
  '-I' + PACKAGE_NAME + '/src/crypto/evp',
  '-I' + PACKAGE_NAME + '/src/crypto/modes',
  '-I' + PACKAGE_NAME + '/src',
]

load('BUILD.generated', 'ssl_headers', 'ssl_internal_headers', 'ssl_sources',
     'crypto_headers', 'crypto_internal_headers', 'crypto_sources',
     'crypto_sources_linux_x86_64')

cc_library(
  name = 'crypto',
  visibility = ["//visibility:public"],
  hdrs = crypto_headers,
  srcs = crypto_internal_headers + crypto_sources + select({
    ":linux_x64": crypto_sources_linux_x86_64,
    "//conditions:default": crypto_sources_linux_x86_64,
  }),
  defines = [
  ],
  includes = [
    'src/include'
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
  defines = [
  ],
  includes = [
    'src/include'
  ],
  copts = openssl_copts,
  linkopts = [
    '-pthread'
  ],
  deps = [
    ':crypto',
  ]
)
