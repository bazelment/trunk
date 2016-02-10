"""Enumerates the build.log from running make and generate bazel build file.

Command to generate build log:
./config no-shared no-dso
make -j8 build_libs | tee ../build.log
"""

import os
import subprocess
import sys


# OS_ARCH_COMBOS maps from OS and platform to the OpenSSL assembly "style" for
# that platform and the extension used by asm files.
OS_ARCH_COMBOS = [
    ('linux', 'arm', 'linux32', [], 'S'),
    ('linux', 'aarch64', 'linux64', [], 'S'),
    ('linux', 'x86', 'elf', ['-fPIC', '-DOPENSSL_IA32_SSE2'], 'S'),
    ('linux', 'x86_64', 'elf', [], 'S'),
]

# NON_PERL_FILES enumerates assembly files that are not processed by the
# perlasm system.
NON_PERL_FILES = {
    ('linux', 'arm'): [
        'src/crypto/chacha/chacha_vec_arm.S',
        'src/crypto/cpu-arm-asm.S',
        'src/crypto/curve25519/asm/x25519-asm-arm.S',
        'src/crypto/poly1305/poly1305_arm_asm.S',
    ],
    ('linux', 'x86_64'): [
        # 'src/crypto/curve25519/asm/x25519-asm-x86_64.S',
    ],
}


class Bazel(object):
  """Bazel outputs files suitable for including in Bazel files."""

  def __init__(self):
    self.firstSection = True
    self.header = \
"""# This file is created by generate_build_files.py. Do not edit manually.

"""

  def PrintVariableSection(self, out, name, files):
    if not self.firstSection:
      out.write('\n')
    self.firstSection = False

    out.write('%s = [\n' % name)
    for f in sorted(files):
      out.write('    "%s",\n' % f)
    out.write(']\n')

  def WriteFiles(self, files, asm_outputs):
    with open('BUILD.generated.bzl', 'w+') as out:
      out.write(self.header)

      self.PrintVariableSection(out, 'ssl_headers', files['ssl_headers'])
      self.PrintVariableSection(
          out, 'ssl_internal_headers', files['ssl_internal_headers'])
      self.PrintVariableSection(out, 'ssl_sources', files['ssl'])
      self.PrintVariableSection(out, 'crypto_headers', files['crypto_headers'])
      self.PrintVariableSection(
          out, 'crypto_internal_headers', files['crypto_internal_headers'])
      self.PrintVariableSection(out, 'crypto_sources', files['crypto'])

      for ((osname, arch), asm_files) in asm_outputs:
        self.PrintVariableSection(
            out, 'crypto_sources_%s_%s' % (osname, arch), asm_files)


def NoTests(dent, is_dir):
  """Filter function that can be passed to FindCFiles in order to remove test
  sources."""
  if is_dir:
    return dent != 'test'
  return 'test.' not in dent and not dent.startswith('example_')


def SSLHeaderFiles(dent, is_dir):
  return dent in ['ssl.h', 'tls1.h', 'ssl23.h', 'ssl3.h', 'dtls1.h']


def GetCompiledFiles():
  """Returns a list of perl asm operations found in the build.log inside src"""
  files = []
  with open('build.log') as f:
    for line in f:
      if not line.startswith('gcc '):
        continue
      line = line.strip()
      # /usr/bin/perl x86_64cpuid.pl elf > x86_64cpuid.s
      params = line.split()
      fname = FindFileInSrc(params[-1])
      if fname:
        files.append(fname)
  return files


def FindHeaderFiles(directory, filter_func):
  """Recurses through directory and returns a list of paths to all the header files that pass filter_func."""
  hfiles = []

  for (path, dirnames, filenames) in os.walk(directory):
    for filename in filenames:
      if not filename.endswith('.h'):
        continue
      if not filter_func(filename, False):
        continue
      hfiles.append(os.path.join(path, filename))

  return hfiles


def FindFileInSrc(perl_file):
  '''Find the full directory under 'src' that contains the given file, which
  could be just x86_64cpuid.pl or something like asm/md5-x86_64.pl'''
  dirname = os.path.dirname(perl_file)
  basename = os.path.basename(perl_file)
  for (path, dirnames, filenames) in os.walk('src'):
    if path.endswith(dirname) and basename in filenames:
      return os.path.join(path, basename)
  return None


def ReadPerlAsmOperations():
  """Returns a list of perl asm operations found in the build.log inside src"""
  perlasms = []
  with open('build.log') as f:
    for line in f:
      if not line.startswith('/usr/bin/perl '):
        continue
      line = line.strip()
      if not line.endswith('.s'):
        continue
      # /usr/bin/perl x86_64cpuid.pl elf > x86_64cpuid.s
      params = line.split()
      perl_file = FindFileInSrc(params[1])
      # Use '.S' suffix to make bazel happy
      output = params[-1][:-1] + 'S'
      perlasms.append({
        'extra_args': [],  # elf in implicit
        # Whether the perl writes output to stdout or takes output file arg
        'use_redirect': params[3] == '>',
        'input': perl_file,
        'output': os.path.join(os.path.dirname(perl_file), output),
      })
  return perlasms


def PerlAsm(output_filename, input_filename, perlasm_style, extra_args,
            use_redirect):
  """Runs the a perlasm script and puts the output into output_filename."""
  base_dir = os.path.dirname(output_filename)
  if not os.path.isdir(base_dir):
    os.makedirs(base_dir)
  command = ['perl', input_filename, perlasm_style] + extra_args
  if not use_redirect:
    command.append(output_filename)
  output = subprocess.check_output(command)
  if use_redirect:
    with open(output_filename, 'w+') as out_file:
      out_file.write(output)


def ArchForAsmFilename(filename):
  """Returns the architectures that a given asm file should be compiled for
  based on substrings in the filename."""

  if 'x86_64' in filename or 'avx2' in filename:
    return ['x86_64']
  elif ('x86' in filename and 'x86_64' not in filename) or '586' in filename:
    return ['x86']
  elif 'armx' in filename:
    return ['arm', 'aarch64']
  elif 'armv8' in filename:
    return ['aarch64']
  elif 'arm' in filename:
    return ['arm']
  else:
    raise ValueError('Unknown arch for asm filename: ' + filename)


def WriteAsmFiles(perlasms):
  """Generates asm files from perlasm directives for each supported OS x
  platform combination."""
  asmfiles = {}

  for osarch in OS_ARCH_COMBOS:
    (osname, arch, perlasm_style, extra_args, asm_ext) = osarch
    key = (osname, arch)
    outDir = '%s-%s' % key

    for perlasm in perlasms:
      filename = os.path.basename(perlasm['input'])
      output = perlasm['output']
      if not output.startswith('src'):
        raise ValueError('output missing src: %s' % output)
      output = os.path.join(outDir, output[4:])
      if output.endswith('-armx.${ASM_EXT}'):
        output = output.replace('-armx',
                                '-armx64' if arch == 'aarch64' else '-armx32')
      output = output.replace('${ASM_EXT}', asm_ext)

      if arch in ArchForAsmFilename(filename):
        PerlAsm(output, perlasm['input'], perlasm_style,
                perlasm['extra_args'] + extra_args, perlasm['use_redirect'])
        asmfiles.setdefault(key, []).append(output)

  for (key, non_perl_asm_files) in NON_PERL_FILES.iteritems():
    asmfiles.setdefault(key, []).extend(non_perl_asm_files)

  return asmfiles


def FilterCfiles(all_files, dir_prefix):
  ret = []
  for fname in all_files:
    if fname.startswith(dir_prefix) and fname.endswith('.c'):
      ret.append(fname)
  return ret

def FixHeadersSymlink(headers_top):
  for (path, dirnames, filenames) in os.walk(headers_top):
    for fname in filenames:
      if fname == 'opensslconf.h':
        # This has to be generated.
        continue
      real_path = FindFileInSrc(fname)
      link = os.path.join(path, fname)
      os.unlink(link)
      os.symlink(os.path.join('..', '..', '..', real_path), link)


def main(platforms):
  all_files = GetCompiledFiles()
  crypto_c_files = FilterCfiles(all_files, os.path.join('src', 'crypto'))
  ssl_c_files = FilterCfiles(all_files, os.path.join('src', 'ssl'))
  arch = 'linux-x86_64'
  headers_top = os.path.join(arch, 'include', 'openssl')
  FixHeadersSymlink(headers_top)

  ssl_h_files = FindHeaderFiles(headers_top, SSLHeaderFiles)

  def NotSSLHeaderFiles(filename, is_dir):
    return not SSLHeaderFiles(filename, is_dir)
  crypto_h_files = FindHeaderFiles(headers_top, NotSSLHeaderFiles)

  ssl_internal_h_files = FindHeaderFiles(os.path.join('src', 'ssl'), NoTests)
  crypto_internal_h_files = FindHeaderFiles(
      os.path.join('src', 'crypto'), NoTests)

  files = {
      'crypto': crypto_c_files,
      'crypto_headers': crypto_h_files,
      'crypto_internal_headers': crypto_internal_h_files,
      'ssl': ssl_c_files,
      'ssl_headers': ssl_h_files,
      'ssl_internal_headers': ssl_internal_h_files,
  }

  asm_outputs = sorted(WriteAsmFiles(ReadPerlAsmOperations()).iteritems())

  for platform in platforms:
    platform.WriteFiles(files, asm_outputs)

  return 0


if __name__ == '__main__':
  platforms = []
  platforms.append(Bazel())

  sys.exit(main(platforms))
