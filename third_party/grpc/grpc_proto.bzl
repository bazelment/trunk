proto_filetype = FileType([".proto"])

def proto_library(name, src, deps = None,
                  generate_cc = True,
                  generate_python = True,
                  has_service = True):
  if has_service:
    proto_cc_deps = [
      "//third_party/protobuf:protoc",
      "//third_party/grpc:grpc_cpp_plugin"
    ]
    cc_deps = [
      "//third_party/protobuf:cc_proto",
      "//third_party/grpc:grpc++"
    ]
  else:
    proto_cc_deps = [
      "//third_party/protobuf:protoc",
    ]
    cc_deps = [
      "//third_party/protobuf:cc_proto"
    ]
  command = "$(location //third_party/protobuf:protoc) --cpp_out=$(GENDIR)/"
  if has_service:
    command += " --grpc_out=$(GENDIR) --plugin=protoc-gen-grpc=$(location //third_party/grpc:grpc_cpp_plugin)"
  command += " $(location %s)" % (src)

  basename = src[0:-5]
  cc_proto_name = name + "_cc_proto"
  native.genrule(
    name = cc_proto_name,
    srcs = [ src ] + proto_cc_deps,
    cmd = command,
    outs = [
      basename + "pb.h",
      basename + "pb.cc"
    ],
  )
  native.cc_library(
    name = name,
    hdrs = [
      basename + "pb.h",
    ],
    srcs = [
      ":" + cc_proto_name
    ],
    deps = cc_deps,
  )
