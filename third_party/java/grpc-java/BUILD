package(default_visibility = ['//visibility:public'])

licenses(['notice'])

cc_binary(
  name = 'grpc_java_plugin',
  srcs = [
    'upstream/compiler/src/java_plugin/cpp/java_generator.cpp',
    'upstream/compiler/src/java_plugin/cpp/java_generator.h',
    'upstream/compiler/src/java_plugin/cpp/java_plugin.cpp',
  ],
  deps = [
    '//external:protobuf_compiler',
  ]
)

java_library(
  name = 'auth',
  srcs = glob([
    'upstream/auth/src/main/java/**/*.java'
  ]),
  deps = [
    ':core',
    '//external:google_auth_library_credentials',
    '//external:jsr305',
    '//third_party/java/guava',
  ],
)

java_library(
  name = 'core',
  srcs = glob([
    'upstream/core/src/main/java/**/*.java'
  ]),
  deps = [
    '//external:jsr305',
    '//third_party/java/guava',
   ],
)

java_library(
  name = 'netty',
  srcs = glob([
    'upstream/netty/src/main/java/**/*.java'
  ]),
  resources = glob([
    'upstream/netty/src/main/resources/**/*',
  ]),
  deps = [
    ':core',
    '//external:jsr305',
    '//third_party/java/guava',
    '//third_party/java/netty',
  ],
  exports = [
    '//third_party/java/netty',
  ],
)

java_library(
  name = 'protobuf',
  srcs = glob([
    'upstream/protobuf/src/main/java/**/*.java'
  ]),
  deps = [
    ':core',
    '//external:protobuf_java_lib',
    '//third_party/java/guava',
    '//external:jsr305',
  ],
)

java_library(
  name = 'okhttp',
  srcs = glob([
    'upstream/okhttp/src/main/java/**/*.java'
  ]),
  resources = glob([
    'upstream/okhttp/src/main/resources/**/*',
  ]),
  deps = [
    ':core',
    '//external:jsr305',
    '//external:okhttp',
    '//external:okio',
    '//third_party/java/guava',
  ],
)

java_library(
  name = 'stub',
  srcs = glob([
    'upstream/stub/src/main/java/**/*.java'
  ]),
  deps = [
    ':core',
    '//third_party/java/guava',
    '//external:jsr305',
  ],
)

java_library(
  name = 'grpc-java',
  exports = [
    ':auth',
    ':core',
    ':netty',
    ':protobuf',
    ':stub',
    '//external:jsr305',
    '//external:protobuf_java_lib',
    '//third_party/java/guava',
  ]
)

# Testing
java_library(
  name = 'testing',
  srcs = glob([
    'upstream/testing/src/main/**/*.java',
  ]),
  deps = [
    ':grpc-java',
  ],
  testonly = 1,
)

java_library(
  name = 'interop',
  srcs = glob([
    'upstream/interop-testing/src/generated/**/*.java',
    'upstream/interop-testing/src/main/**/*.java',
  ]),
  testonly = 1,
  deps = [
    ':grpc-java',
    ':testing',
    ':netty',
    '//external:google_auth_library_oauth2_http',
    '//external:junit',
    '//external:mockito',
    '//third_party/java/netty',
  ],
)

java_test(
  name = 'interop_test',
  srcs = glob([
    'upstream/interop-testing/src/test/**/*.java',
  ]),
  deps = [
    '//external:junit',
    '//external:mockito',
    '//external:okhttp',
    ':grpc-java',
    ':interop',
    ':netty',
    ':testing',
  ],
  tags = [
    'manual',
  ],
  args = [
    'io.grpc.stub.StubConfigTest',
    'io.grpc.testing.integration.InProcessTest',
  ],
  runtime_deps = [
    '//external:hamcrest',  # By junit
    '//external:objenesis',  # By mockito
  ]
)
