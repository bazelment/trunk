# Convert proto definition to C++/Java code
# based on https://github.com/google/kythe/blob/master/tools/build_rules/proto.bzl

def collect_proto_sources(ctx):
  source_files = set(order="compile")
  for dep in ctx.attr.deps:
    source_files += dep.proto_src
  source_files += [ctx.file.src]
  return source_files

def _genproto_impl(ctx):
  proto_srcs = collect_proto_sources(ctx)
  inputs, outputs, arguments = list(proto_srcs), [], []
  if ctx.attr.gen_cc:
    outputs += [ctx.outputs.cc_hdr, ctx.outputs.cc_src]
    arguments += ["--cpp_out=" + ctx.configuration.genfiles_dir.path]
    if ctx.attr.has_service:
      grpc_cpp_plugin = ctx.executable.grpc_cpp_plugin
      inputs += [grpc_cpp_plugin]
      outputs += [ctx.outputs.cc_grpc_hdr, ctx.outputs.cc_grpc_src]
      arguments += [
        "--grpc_out=" + ctx.configuration.genfiles_dir.path,
        "--plugin=protoc-gen-grpc=" + grpc_cpp_plugin.path,
      ]

  if ctx.attr.gen_java:
    # Create .jar file base on .srcjar file name
    srcjar = ctx.new_file(ctx.outputs.java_src.basename[:-6] + "jar")
    outputs += [srcjar]
    arguments += ["--java_out=" + srcjar.path]
    if ctx.attr.has_service:
      java_grpc_plugin = ctx.executable.grpc_java_plugin
      inputs += [java_grpc_plugin]
      arguments += [
        "--plugin=protoc-gen-java_rpc=" + java_grpc_plugin.path,
        "--java_rpc_out=" + srcjar.path
      ]

  ctx.action(
      mnemonic = "GenProto",
      inputs = inputs,
      outputs = outputs,
      arguments = arguments + [ctx.file.src.path],
      executable = ctx.executable._protoc)
  # This is required because protoc only understands .jar extensions, but Bazel
  # requires source JAR files end in .srcjar.
  if ctx.attr.gen_java and srcjar != ctx.outputs.java_src:
    ctx.action(
        mnemonic = "FixProtoSrcJar",
        inputs = [srcjar],
        outputs = [ctx.outputs.java_src],
        arguments = [srcjar.path, ctx.outputs.java_src.path],
        command = "cp $1 $2")
    # Fixup the resulting outputs to keep the source-only .jar out of the result.
    outputs += [ctx.outputs.java_src]
    outputs = [e for e in outputs if e != srcjar]

  return struct(files=set(outputs),
                proto_src=proto_srcs)

_genproto_attrs = {
  "src": attr.label(
    allow_files = FileType([".proto"]),
    mandatory = True,
    single_file = True,
  ),
  "deps": attr.label_list(
    allow_files = False,
    providers = ["proto_src"],
  ),
  "has_service": attr.bool(),
  "_protoc": attr.label(
    default = Label("//external:protoc"),
    cfg = HOST_CFG,
    executable = True,
  ),
  "grpc_cpp_plugin": attr.label(
    # We don't specify the default here, otherwise it imposes an
    # implicit dependency to the plugin, which we may not need
    # depending on the whether gen_cc is true.
    # default = Label("//external:grpc_cpp_plugin"),
    cfg = HOST_CFG,
    executable = True
  ),
  "grpc_java_plugin": attr.label(
    # default = Label("//external:grpc_java_plugin"),
    cfg = HOST_CFG,
    executable = True,
  ),
  "gen_cc": attr.bool(),
  "gen_java": attr.bool(),
}

def _genproto_outputs(attrs):
  outputs = {}
  if attrs.gen_cc:
    outputs += {
      "cc_hdr": "%{src}.pb.h",
      "cc_src": "%{src}.pb.cc"
    }
    if attrs.has_service:
      outputs += {
        "cc_grpc_hdr": "%{src}.grpc.pb.h",
        "cc_grpc_src": "%{src}.grpc.pb.cc"
      }

  if attrs.gen_java:
    outputs += {
      "java_src": "%{src}.srcjar",
    }
  return outputs


# Use protoc compiler to convert a single .proto file to CPP/Java
# files.
genproto = rule(
  _genproto_impl,
  attrs=_genproto_attrs,
  output_to_genfiles=True,
  outputs=_genproto_outputs,
)

def proto_library(name, src, deps=[],
                  visibility=None,
                  generate_cc=True,
                  generate_go=False,
                  generate_java=False,
                  generate_python=False,
                  has_service=False):
  # TODO(mzhao) python, go code generation is unsupported.
  # print(name)
  genproto_deps = [dep + "_genproto" for dep in deps]
  # print(genproto_deps)
  if generate_cc and has_service:
    grpc_cpp_plugin = "//external:grpc_cpp_plugin"
  else:
    grpc_cpp_plugin = None
  if generate_java and has_service:
    grpc_java_plugin = "//third_party/java/grpc-java:grpc_java_plugin"
  else:
    grpc_java_plugin = None
  proto_pkg = genproto(
    name=name + "_genproto",
    visibility = visibility,
    src=src,
    deps=genproto_deps,
    has_service=has_service,
    gen_cc=generate_cc,
    gen_java=generate_java,
    grpc_java_plugin = grpc_java_plugin,
    grpc_cpp_plugin = grpc_cpp_plugin)

  if generate_cc:
    cc_deps = ["//external:protobuf_clib"]
    if has_service:
      cc_deps += ["//external:grpc++"]
    cc_deps += deps
    native.cc_library(
      name = name,
      visibility = visibility,
      hdrs = [proto_pkg.label()],
      srcs = [proto_pkg.label()],
      defines = ["GOOGLE_PROTOBUF_NO_RTTI"],
      deps = cc_deps,
    )

  if generate_java:
    java_deps = ["//external:protobuf_java_lib"]
    if has_service:
      java_deps += [
        "//third_party/java/grpc-java",
      ]
    for dep in deps:
      java_deps += [dep + "_java"]
    native.java_library(
      name  = name + "_java",
      visibility = visibility,
      srcs = [proto_pkg.label()],
      deps = java_deps,
    )
