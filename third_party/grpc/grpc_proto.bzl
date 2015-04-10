proto_filetype = FileType([".proto"])

def proto_library(name, src, deps = None,
                  generate_cc = True,
                  generate_python = True,
                  has_service = True):
  if has_service:
    proto_cc_deps = [
      "//external:protoc",
      "//external:grpc_cpp_plugin"
    ]
    cc_deps = [
      "//external:protobuf_clib",
      "//external:grpc++"
    ]
  else:
    proto_cc_deps = [
      "//external:protoc",
    ]
    cc_deps = [
      "//external:protobuf_clib"
    ]
  command = "$(location //external:protoc) --cpp_out=$(GENDIR)/"
  if has_service:
    command += " --grpc_out=$(GENDIR) --plugin=protoc-gen-grpc=$(location //external:grpc_cpp_plugin)"
  command += " $(location %s)" % (src)

  basename = src[0:-5]
  cc_proto_name = name + "_cc_proto"
  header_outputs = [
    basename + "pb.h",
  ]
  outputs = header_outputs + [
    basename + "pb.cc",
  ]
  if has_service:
    header_outputs += [basename + "grpc.pb.h"]
    outputs += [
      basename + "grpc.pb.h",
      basename + "grpc.pb.cc",
    ]
      
  native.genrule(
    name = cc_proto_name,
    srcs = [ src ] + proto_cc_deps,
    cmd = command,
    outs = outputs,
  )
  native.cc_library(
    name = name,
    hdrs = header_outputs,
    srcs = [
      ":" + cc_proto_name
    ],
    deps = cc_deps,
  )
