package(default_visibility = ["//visibility:public"])

filegroup(
    name = "jni_header",
    srcs = ["//external:jni_header"],
)

filegroup(
    name = "jni_md_header-darwin",
    srcs = ["//external:jni_md_header-darwin"],
)

filegroup(
    name = "jni_md_header-linux",
    srcs = ["//external:jni_md_header-linux"],
)

filegroup(
    name = "java",
    srcs = ["//external:java"],
)

filegroup(
    name = "jar",
    srcs = ["//external:jar"],
)

filegroup(
    name = "javac",
    srcs = ["//external:javac"],
)

BOOTCLASS_JARS = [
    "rt.jar",
    "resources.jar",
    "jsse.jar",
    "jce.jar",
    "charsets.jar",
]

filegroup(
    name = "bootclasspath",
    srcs = ["//external:bootclasspath"],
)

filegroup(
    name = "extdir",
    srcs = ["//external:extdir"],
)

filegroup(
    name = "langtools",
    srcs = ["//third_party/java/jdk/langtools:javac_jar"],
)

java_import(
    name = "langtools-neverlink",
    jars = [":langtools"],
    neverlink = 1,
)

# This one is just needed because of how filegroup redirection works.
filegroup(name = "jdk-null")

filegroup(
    name = "jdk",
    srcs = [
        ":jdk-null",
        "//external:jdk-default",
    ],
)

java_toolchain(
    name = "toolchain",
    bootclasspath = [":bootclasspath"],
    encoding = "UTF-8",
    extclasspath = [":extdir"],
    genclass = ["//tools/jdk:GenClass_deploy.jar"],
    header_compiler = ["//tools/jdk:turbine_deploy.jar"],
    ijar = ["//tools/jdk:ijar"],
    javabuilder = ["//tools/jdk:JavaBuilder_deploy.jar"],
    javac = ["//third_party/java/jdk/langtools:javac_jar"],
    jvm_opts = [
        "-XX:+TieredCompilation",
        "-XX:TieredStopAtLevel=1",
    ],
    singlejar = ["//tools/jdk:SingleJar_deploy.jar"],
    source_version = "7",
    target_version = "7",
    misc = [
        "-extra_checks:off",
    ],
)

filegroup(
    name = "ijar",
    srcs = [
        "//third_party/ijar:ijar",
    ],
)

exports_files([
    "GenClass_deploy.jar",
    "JavaBuilder_deploy.jar",
    "SingleJar_deploy.jar",
])

filegroup(
    name = "srcs",
    srcs = ["BUILD"],  # Tools are build from the workspace for tests.
)
