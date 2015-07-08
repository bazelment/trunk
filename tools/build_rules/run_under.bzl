# This file creates custom rules to make tests can easily run under
# certain environment(like inside a docker).
#
# For example:
#
# run_under_test(
#   name = "test_under_docker",
#   under = "//tools/docker:zookeper",
#   command = "//sometest",
#   data = [
#   ],
#   args = [
#     "--gtest_filter=abc",
#   ]
# )
#
# This is almost equivalent to
# bazel run --script_path "name" --run_under "under" "command"
def _run_under_impl(ctx):
  bin_dir = ctx.data_configuration.bin_dir
  build_directory = str(bin_dir)[:-len('[derived]')] + '/'
  print(build_directory)
  under = ctx.executable.under
  command = ctx.executable.command
  exe = ctx.outputs.executable
  ctx.file_action(output=exe,
                  content='''#!/bin/bash
cd %s.runfiles && \\
exec %s %s \\
%s \\
%s "$@"
''' % (build_directory + exe.short_path,
       build_directory + under.short_path,
       " ".join(ctx.attr.under_args),
       build_directory + command.short_path,
       " ".join(ctx.attr.args)))
  runfiles = [command, under] + ctx.files.data
  return struct(
    runfiles=ctx.runfiles(files=runfiles)
  )

run_under_attr = {
  "command": attr.label(mandatory=True,
                        allow_files=True,
                        executable=True),
  "under": attr.label(mandatory=True,
                      allow_files=True,
                      executable=True),
  # Arguments for the "under" command to setup the environment.
  "under_args": attr.string_list(),
  "data": attr.label_list(allow_files=True,
                          cfg=DATA_CFG),
  "args": attr.string_list(),
}

run_under_binary = rule(
  _run_under_impl,
  attrs = run_under_attr,
  executable=True)

run_under_test = rule(
  _run_under_impl,
  test = True,
  attrs = run_under_attr,
  executable=True)
