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
#
# under: any build target that produces an executable binary, this is
# the top level command to run, and it should take another executable
# as command line flag to run as subprocess.
#
# command: any build target that produces an executable binary.
#
# data: list of files that need to be accessed when running the
# "under" and the "command".
def _run_under_impl(ctx):
    under = ctx.executable.under
    command = ctx.executable.command
    exe = ctx.outputs.executable

    # Tests and `bazel run` both start with the runfiles directory of the main
    # repository as the working directory, so short_path is what the wrapper
    # needs to reference the two binaries.
    ctx.actions.write(
        output = exe,
        is_executable = True,
        content = """#!/bin/bash
set -e
exec ./{under} {under_args} ./{command} "$@"
""".format(
            under = under.short_path,
            under_args = " ".join(ctx.attr.under_args),
            command = command.short_path,
        ),
    )

    # The "$@" above passes ctx.attr.args along to the command.
    runfiles = ctx.runfiles(files = [command, under] + ctx.files.data)
    runfiles = runfiles.merge_all([
        ctx.attr.under[DefaultInfo].default_runfiles,
        ctx.attr.command[DefaultInfo].default_runfiles,
    ])
    return [DefaultInfo(executable = exe, runfiles = runfiles)]

run_under_attr = {
    "command": attr.label(
        mandatory = True,
        allow_files = True,
        cfg = "target",
        executable = True,
    ),
    "under": attr.label(
        mandatory = True,
        allow_files = True,
        cfg = "target",
        executable = True,
    ),
    # Arguments for the "under" command to setup the environment.
    "under_args": attr.string_list(),
    "data": attr.label_list(allow_files = True, cfg = "target"),
    # bazel automatically implements "args": attr.string_list()
    # and passes them on invocation
}

run_under_binary = rule(
    implementation = _run_under_impl,
    attrs = run_under_attr,
    executable = True,
)

run_under_test = rule(
    implementation = _run_under_impl,
    test = True,
    attrs = run_under_attr,
    executable = True,
)
