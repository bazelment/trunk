workspace(name = "com_github_bazelment_trunk")

# clang compiler setting
load("//third_party/clang_toolchain:cc_configure_clang.bzl", "cc_download_clang_toolchain")
cc_download_clang_toolchain(name = "local_config_download_clang")

local_repository(
  # Name of the Abseil repository. This name is defined within Abseil's
  # WORKSPACE file, in its `workspace()` metadata
  name = "com_google_absl",

  # NOTE: Bazel paths must be absolute paths. E.g., you can't use ~/Source
  path = "third_party/abseil",
)

local_repository(
    name = "com_google_googletest",
    path = "third_party/gtest/github",
)

bind(
  name = "gtest",
  actual = "@com_google_googletest//:gtest",
)

bind(
  name = "gtest_main",
  actual = "@com_google_googletest//:gtest_main",
)

bind(
  name = "libssl",
  actual = "//third_party/openssl:ssl",
)

local_repository(
  name = "com_google_protobuf",
  path = "third_party/protobuf",
)

new_local_repository(
  name = "zlib",
  path = "third_party/zlib/upstream",
  build_file = "@com_google_protobuf//:third_party/zlib.BUILD",
)

local_repository(
  name = "com_google_glog",
  path = "third_party/glog/upstream",
)

bind(
  name = "glog",
  actual = "@com_google_glog//:glog",
)

new_local_repository(
  name = "com_github_gflags_gflags",
  path = "third_party/gflags/upstream",
  build_file = "third_party/gflags/upstream/BUILD",
)

# So gflags can be accessed via //external:gflags.
bind(
  name = "gflags",
  actual = "@com_github_gflags_gflags//:gflags",
)


new_local_repository(
    name = "submodule_cares",
    path = "third_party/cares",
    build_file = "third_party/cares/cares.BUILD",
)

bind(
    name = "cares",
    actual = "@submodule_cares//:ares",
)

# Load grpc and its dependencies
local_repository(
  name = "com_github_grpc_grpc",
  path = "third_party/grpc",
  # build_file = "third_party/grpc/BUILD",
)

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps", "grpc_test_only_deps")
grpc_deps()
grpc_test_only_deps()

load("@com_github_grpc_grpc//bazel:grpc_extra_deps.bzl", "grpc_extra_deps")
grpc_extra_deps()

# GRPC C++ runtime library
bind(
    name = "grpc++",
    actual = "@com_github_grpc_grpc//:grpc++"
)

# End grpc

load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

jvm_maven_import_external(
  name = "apache_commons_lang2_maven",
  artifact = "commons-lang:commons-lang:2.6",
  server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "apache_commons_lang2",
  actual = "@apache_commons_lang2_maven//jar"
)

jvm_maven_import_external(
  name = "apache_commons_lang3_maven",
  artifact = "org.apache.commons:commons-lang3:3.4",
  server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "apache_commons_lang3",
  actual = "@apache_commons_lang3_maven//jar"
)

bind(
  name = "apache_commons_logging",
  actual = "//third_party/java/commons-logging"
)

bind(
  name = "apache_log4j",
  actual = "//third_party/java/log4j"
)

jvm_maven_import_external(
    name = "gson_maven",
    artifact = "com.google.code.gson:gson:2.7",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
    name = "gson",
    actual = "@gson_maven//jar",
)

bind(
    name = "guava",
    actual = "//third_party/java/guava",
)

jvm_maven_import_external(
    name = "hpack_maven",
    artifact = "com.twitter:hpack:v1.0.1",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "hpack",
  actual = "@hpack_maven//jar"
)

bind(
  name = "javassist",
  actual = "//third_party/java/javassist",
)

jvm_maven_import_external(
    name = "jetty_alpn_maven",
    artifact = "org.eclipse.jetty.alpn:alpn-api:1.1.2.v20150522",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "jetty_alpn",
  actual = "@jetty_alpn_maven//jar"
)

jvm_maven_import_external(
    name = "jetty_npn_maven",
    artifact = "org.mortbay.jetty.npn:npn-boot:1.1.11.v20150415",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "jetty_npn",
  actual = "@jetty_npn_maven//jar"
)

jvm_maven_import_external(
    name = "joda_time_maven",
    artifact = "joda-time:joda-time:2.3",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "joda_time",
  actual = "@joda_time_maven//jar"
)

jvm_maven_import_external(
    name = "jzlib_maven",
    artifact = "com.jcraft:jzlib:1.1.3",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "jzlib",
  actual = "@jzlib_maven//jar"
)

jvm_maven_import_external(
    name = "netty_tcnative_maven",
    artifact = "io.netty:netty-tcnative:1.1.33.Fork7",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "netty_tcnative",
  actual = "@netty_tcnative_maven//jar"
)

bind(
  name = "slf4j",
  actual = "//third_party/java/slf4j"
)

# grpc-java dependencies
bind(
  name = "jsr305",
  actual = "//third_party/java/jsr305"
)

jvm_maven_import_external(
    name = "google_auth_library_oauth2_http_maven",
    artifact = "com.google.auth:google-auth-library-oauth2-http:0.2.0",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "google_auth_library_oauth2_http",
  actual = "@google_auth_library_oauth2_http_maven//jar"
)

jvm_maven_import_external(
    name = "google_auth_library_credentials_maven",
    artifact = "com.google.auth:google-auth-library-credentials:0.2.0",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "google_auth_library_credentials",
  actual = "@google_auth_library_credentials_maven//jar"
)

jvm_maven_import_external(
    name = "guice_maven",
    artifact = "com.google.inject:guice:4.0",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "guice",
  actual = "@guice_maven//jar"
)

jvm_maven_import_external(
    name = "guice_multibindings_maven",
    artifact = "com.google.inject.extensions:guice-multibindings:4.0",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "guice_multibindings",
  actual = "@guice_multibindings_maven//jar"
)

jvm_maven_import_external(
    name = "hamcrest_maven",
    artifact = "org.hamcrest:hamcrest-core:1.3",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "hamcrest",
  actual = "@hamcrest_maven//jar"
)

jvm_maven_import_external(
    name = "junit_maven",
    artifact = "junit:junit:4.11",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "junit",
  actual = "@junit_maven//jar"
)

jvm_maven_import_external(
    name = "objenesis_maven",
    artifact = "org.objenesis:objenesis:2.1",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "objenesis",
  actual = "@objenesis_maven//jar"
)

jvm_maven_import_external(
    name = "mockito_maven",
    artifact = "org.mockito:mockito-core:1.10.19",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "mockito",
  actual = "@mockito_maven//jar"
)

jvm_maven_import_external(
    name = "okhttp_maven",
    artifact = "com.squareup.okhttp:okhttp:2.4.0",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "okhttp",
  actual = "@okhttp_maven//jar"
)

jvm_maven_import_external(
    name = "okio_maven",
    artifact = "com.squareup.okio:okio:1.5.0",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "okio",
  actual = "@okio_maven//jar"
)

jvm_maven_import_external(
    name = "commons_cli_maven",
    artifact = "commons-cli:commons-cli:1.2",
    server_urls = ["http://central.maven.org/maven2"],
)

bind(
  name = "commons_cli",
  actual = "@commons_cli_maven//jar"
)

# Disable loading of any android depenedency rule
bind(name = "android/aar_generator")
bind(name = "android/incremental_split_stub_application")
bind(name = "android/incremental_stub_application")
bind(name = "android/resources_processor")

# Google benchmark.
http_archive(
    name = "com_github_google_benchmark",
    urls = ["https://github.com/google/benchmark/archive/16703ff83c1ae6d53e5155df3bb3ab0bc96083be.zip"],
    strip_prefix = "benchmark-16703ff83c1ae6d53e5155df3bb3ab0bc96083be",
    sha256 = "59f918c8ccd4d74b6ac43484467b500f1d64b40cc1010daa055375b322a43ba3",
)
