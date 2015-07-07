# bazel macro to generate deb package
def _build_deps_file(ctx, output_file):
  commands = ['%s->%s' % (f.short_path, f.path)
              for f in ctx.files.deps]
  ctx.file_action(
    output = output_file,
    content = '\n'.join(commands))


def _pkg_deb_impl(ctx):
  # fastbuild, dbg or opt
  compilation_mode = ctx.var['COMPILATION_MODE']
  build_config = ctx.attr.build_config
  toolchain_name = ctx.var['CC']

  pkg_name = ctx.label.name + '-' + compilation_mode
  build_config_command = ''
  if build_config:
    pkg_name += '-' + build_config
    build_config_command = ' --config=' + build_config

  # The output zip file that contains deb file internally.
  deb_zip = ctx.outputs.deb_zip
  publish_script = ctx.outputs.executable

  copyright = ctx.attr.copyright
  if not copyright:
    copyright = 'Unknown'
  description = ctx.attr.description
  if not description:
    description = ''
  description += ('\nBuilt with bazel build -c ' + compilation_mode
                  + build_config_command +
                  ' ' + str(ctx.label) +
                  '\n  crosstool ' + toolchain_name)

  # 1. Generate the list of files to be included in the deb file
  deps_file = ctx.new_file(deb_zip, '.deps.list')
  _build_deps_file(ctx, deps_file)

  # 2. Generate meta file that contains copyright, description
  # information that can't be easily passed around command line.
  meta_file = ctx.new_file(deb_zip, '.meta')
  ctx.file_action(
    output=meta_file,
    content='''--copyright
%s
--description
%s
''' % (copyright, description))

  # 2. Build the deb package and pack it into zip file
  deb_builder = ctx.executable._deb_builder
  arguments = [
    '--pkg_name=' + pkg_name,
    '--zipfile=' + deb_zip.path,
    '--publish_script=' + publish_script.path,
    '--output=' + deb_zip.path + '.debian_staging',
    '--list_file=' + deps_file.path,
  ]

  if ctx.attr.version_prefix:
    arguments += ['--version_prefix=' + ctx.attr.version_prefix]
  for short_path, final_path in ctx.attr.file_map.items():
    if short_path.find('*') != -1:
      fail('wildcard * should not be used in file_map: ' + short_path)
    if short_path[0] == '/':
      fail('the short path should not start with /: ' + short_path)
    if final_path[0] == '/':
      fail('the path inside the package should be relative path: ' + final_path)
    arguments += ['--file_map=' + short_path + '=' + final_path]
  arguments += [ '@' + meta_file.path]
  # print(arguments)
  ctx.action(
    inputs = ctx.files.deps + [
      # This one present dependency to bazel-out/stable-status.txt
      ctx.info_file,
      deps_file,
      meta_file],
    outputs = [deb_zip, publish_script],
    executable = deb_builder,
    arguments = arguments,
    mnemonic = 'PackageDeb',
    progress_message='Building %s' % (deb_zip.short_path),
  )


pkg_deb_ = rule(
  _pkg_deb_impl,
  attrs = {
    'deps': attr.label_list(mandatory=True, allow_files=True),
    'copyright': attr.string(),
    'description': attr.string(),
    'version_prefix': attr.string(default='1.0'),
    'file_map': attr.string_dict(),
    'build_config': attr.string(),
    '_deb_builder': attr.label(
      # TODO: add cfg=HOST_CFG once python2 issue is resolved.
      default=Label('//tools/deb:deb_builder'),
      executable=True,
      allow_files=True),
  },
  executable = True,
  outputs = {
    'deb_zip': '%{name}.zip',
  })


# We have to introduce another level of indirection because select's
# result can't be accessed within the build rule definition directly.
def pkg_deb(name = None,
            deps=[],
            visibility=None,
            copyright=None,
            description=None,
            version_prefix='1.0',
            file_map={}):
  pkg_deb_(name = name,
           deps = deps,
           visibility = visibility,
           copyright = copyright,
           description = description,
           version_prefix = version_prefix,
           file_map = file_map,
           build_config = select({
             '//tools/cpp:asan_enabled': 'asan',
             '//tools/cpp:msan_enabled': 'msan',
             '//tools/cpp:tsan_enabled': 'tsan',
             '//tools/cpp:ubsan_enabled': 'ubsan',
             '//conditions:default': '',
           }))
