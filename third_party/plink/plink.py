#!/usr/bin/python2.7

# Link a python source tree into a single self-executing zip archive.
# The zip can also be extracted and run manually.
#
# Distributed under a BSD license.
# Copyright (c) 2012-2014 Mike Solomon

import cStringIO
import compileall
import imp
import marshal
import optparse
import os
import shutil
import string
import sys
import zipfile

bootstrap_src_tmpl = r"""
# ParImporter bootstrap
# 
# Insert a custom importer to allow compressed .so files to load transparently.
#
# ${tracer}
import __builtin__
import cStringIO
import errno
import hashlib
import imp
import marshal
import os
import sys
import tempfile
import traceback
import zipfile
import zipimport

# Extra debugging by brute force. Disabled in the average case.
def enable_debug():
  _python_import = __import__
  def plink_import(name, globals=None, locals=None, fromlist=None, level=-1):
    log('__import__ %s %s', name, fromlist)
    try:
      return _python_import(name, globals, locals, fromlist, level)
    except ImportError:
      log('__import__ %s %s failed', name, fromlist)
      log('  sys.path: %s', sys.path)
      log('  sys.path_hooks: %s', sys.path_hooks)
      log('  sys.path_importer_cache: %s', list(sorted(sys.path_importer_cache.iteritems())))
      raise

  __builtin__.__import__ = plink_import

def log(fmt, *args):
  if os.environ.get('PLINK_DEBUG'):
    if args:
      fmt = fmt % args
    print >> sys.stderr, 'plink: debug', fmt

def log_warning(fmt, *args):
  if args:
    fmt = fmt % args        
  print >> sys.stderr, 'plink: warning', fmt

class ParImporter(zipimport.zipimporter):
  def __init__(self, path):
    if not path.startswith(sys.path[0]):
      # Normally the first path item will be the our self-executing zip.
      # Otherwise, just skip it.
      log('ParImporter ignoring path:%s', path)
      raise ImportError('invalid ParImporter path', path)
    self.data_cache = {}
    zipimport.zipimporter.__init__(self, path)
    log('ParImporter init path:%s archive:%s prefix:%s', path, self.archive, self.prefix)

  def __repr__(self):
    return '<ParImporter %s>' % self.archive
  
  def find_module(self, fullname, path=None):
    log('find_module %s %s', fullname, path)
    data_path = fullname.replace('.', '/') + '.so'

    # Check for native .so modules first and track what needs to be extracted
    # before an import is run.
    try:
      self.data_cache[fullname] = self.get_data(data_path)
      log('found data_path:%s fullname:%s', data_path, fullname)
      return self
    except IOError:
      # This just means there was no data, which is expected sometimes.
      pass
    
    return zipimport.zipimporter.find_module(self, fullname, path)

  def load_module(self, fullname):
    if fullname in sys.modules:
      log('load_module %s (cached)', fullname)
      return sys.modules[fullname]

    if fullname in self.data_cache:
      # This resource must be extracted to a physical file.
      data = self.data_cache[fullname]
      del self.data_cache[fullname]
      bin_name = os.path.basename(sys.path[0])
      par_dir = '%s/%s-%s' % (tempfile.gettempdir(), bin_name, par_signature)
      try:
        os.mkdir(par_dir)
      except OSError as e:
        if e[0] != errno.EEXIST:
          raise e
      path = '%s/%s.so' % (par_dir, fullname)
      if not os.path.exists(path):
        log('load_module %s (extracting to %s)', fullname, path)
        tmp_path = path + '-' + os.urandom(8).encode('hex')
        with open(tmp_path, 'wb') as f:
          f.write(data)
        # Atomically rename so you don't get partially extracted files.
        os.rename(tmp_path, path)
      else:
        log('load_module %s (extracted to %s)', fullname, path)

      for suffix, file_mode, module_type in imp.get_suffixes():
        if path.endswith(suffix):
          s = (suffix, file_mode, module_type)
          f = open(path, file_mode)
          mod = imp.load_module(fullname, f, path, s)
          mod.__loader__ = self
          return mod
      raise ImportError('No module for %s (plink)' % fullname)

    log('load_module %s (default)', fullname)
    module = zipimport.zipimporter.load_module(self, fullname)
    return module

# Override the source returned. Otherwise the __run__ and __main__
# modules get confused because both must be run as main to preserve
# existing script behaviors.
class SourceLoader(object):
  def __init__(self, loader, source_map):
    self.loader = loader
    self.source_map = source_map

  def __getattr__(self, name):
    return getattr(self.loader, name)
  
  def get_source(self, fullname):
    if fullname in self.source_map:
      return self.source_map[fullname]
    return self.loader.get_source(fullname)


compile_pymagic = ${compile_pymagic}

# Quickly rename our module out of the way to prevent a confusing stack trace.
newname = '_par_bootstrap_'
_par_bootstrap_ = sys.modules[__name__]
_par_bootstrap_.__name__ = newname
sys.modules[newname] = _par_bootstrap_
del sys.modules[__name__]
par_signature = '<unsigned>'

if os.environ.get('PLINK_DEBUG'):
  enable_debug()

sys.path_hooks.insert(0, ParImporter)
log('initial sys.path: %s', sys.path)
log('initial sys.path_hooks: %s', sys.path_hooks)
log('initial sys.path_importer_cache: %s', list(sorted(sys.path_importer_cache.iteritems())))

m = hashlib.md5()
with open(sys.path[0]) as f:
  while True:
    block = f.read(1024*1024)
    if block:
      m.update(block)
    else:
      break
par_signature = m.hexdigest()

zf = zipfile.ZipFile(sys.path[0], 'r')
source_map = {
  '_par_bootstrap_': zf.read('__main__.py'),
  '__main__': zf.read('__run__.py'),
  }

# Overwrite the default loader.
__loader__ = SourceLoader(__loader__, source_map)

# Overwrite the cached zipimporter with a ParImport so top-level .so dependencies
# will be correctly resolved.
sys.path_importer_cache[zf.filename] = ParImporter(zf.filename)

runtime_pymagic = imp.get_magic() + '\000\000\000\000'
if runtime_pymagic != compile_pymagic:
  log_warning('runtime / linktime mismatch - ignoring .pyc files')
  run_py = zf.read('__run__.py')
  run_code = compile(run_py, '__run__.py', 'exec')
else:
  run_pyc = zf.read('__run__.pyc')
  run_code = marshal.loads(run_pyc[len(runtime_pymagic):])
zf.close()

run_globals = {
  '__name__': '__main__',
  '__loader__': __loader__,
}

try:
  exec run_code in run_globals
except Exception:
  # Force the pure-python traceback printer, which correctly calls the loader
  # to resolve traceback sources.
  traceback.print_exc()

"""


tracer = 'plink-tracer-19810319'
zipmagic = '\x50\x4B\x03\x04'
compile_pymagic = imp.get_magic() + '\000\000\000\000'

def mkbootstrap():
  tmpl = string.Template(bootstrap_src_tmpl)
  return tmpl.substitute(tracer=tracer, compile_pymagic=repr(compile_pymagic))

# Takes a directory and makes a zip file containing any files therein
# that are (normally) loadable by Python.
def zipdir(source_root, data_paths, options):
  source_root = os.path.normpath(source_root)
  compileall.compile_dir(source_root, ddir='', quiet=True)
  prefix = source_root + '/'
  b = cStringIO.StringIO()
  z = zipfile.ZipFile(b, 'w', zipfile.ZIP_DEFLATED)
  for root, dirs, files in os.walk(source_root):
    for f in sorted(files):
      if f.endswith(('.py', '.pyc', '.pyo', '.so')):
        if options.strip and f.endswith('.py'):
          continue
        realpath = os.path.join(root, f)
        arcpath = realpath.replace(prefix, '')
        log('deflate %s -> %s', realpath, arcpath)
        z.write(realpath, arcpath)
  for data_path in sorted(data_paths):
    realpath = os.path.normpath(data_path)
    arcpath = realpath.replace(prefix, '')
    log('deflate %s -> %s', realpath, arcpath)
    z.write(realpath, arcpath)
    
  z.close()
  return b.getvalue()

def copy_package(name, path, pkg_dir):
  log('copy package %s %s -> %s', name, path, pkg_dir)
  if path.endswith('.so'):
    return shutil.copy(path, pkg_dir)
  filename, _ = os.path.splitext(os.path.basename(path))
  if filename == '__init__':
    target = os.path.join(pkg_dir, name)
    if os.path.isdir(target):
      shutil.rmtree(target)
    return shutil.copytree(os.path.dirname(path), target)
  raise Exception('unknown package type', name, path)
  

# Generate a list of all names and paths that are required simply
# to import a given module.
def get_import_dependencies(module_name):
  initial_names = frozenset(k for k,v in sys.modules.iteritems() if v)
  m = __import__(module_name)
  imported_names = frozenset(k for k,v in sys.modules.iteritems() if v) - initial_names
  for name in sorted(imported_names):
    path = getattr(sys.modules[name], '__file__', 'built-in')
    # FIXME(mike) Sloppy heuristic here.
    if 'dist-packages' in path:
      yield name, path

# Copy packages from the system install to the local staging area.
# This is an escape hatch for less precise dependency management.
def prepare_sys_packages(sys_pkg_list, pkg_dir):
  top_packages = {}
  for pkg in sys_pkg_list:
    for dep_pkg, dep_path in get_import_dependencies(pkg):
      top_package = dep_pkg.split('.')[0]
      if top_package not in top_packages:
        top_packages[top_package] = dep_path

  for pkg, path in sorted(top_packages.iteritems()):
    copy_package(pkg, path, pkg_dir)


def log(fmt, *args):
  return _log(0, fmt, *args)

def log_debug(fmt, *args):
  return _log(1, fmt, *args)

def _log(log_level, fmt, *args):
  if options.verbose > log_level:
    if args:
      fmt = fmt % args
    print >> sys.stderr, fmt


options = None
usage = """
%prog --main-file <main source file> --pkg-dir <zip source directory> [<data file>, ...]

PLINK_DEBUG=1 ./pyapp.par
"""

if __name__ == '__main__':
  p = optparse.OptionParser(usage=usage)
  p.add_option('-v', '--verbose', action='count', default=0)
  p.add_option('-o', '--output')
  p.add_option('--strip', action='store_true', help='strip .py files')
  p.add_option('--format', default='par')
  p.add_option('--main-file',
               help='name of python to run after bootstrap')
  p.add_option('--python-binary', default=sys.executable + ' -ESs',
               help='adjust the shebang line of the output')
  p.add_option('--pkg-dir', default=None)
  p.add_option('-L', '--system-module', action='append',
               help='copy a system package / module into the staging area')
  (options, args) = p.parse_args()

  if not options.main_file:
    sys.exit('--main-file must be specified')

  if not options.pkg_dir:
    sys.exit('--pkg-dir must be specified')

  if not options.output:
    options.output = '%s.%s' % (os.path.basename(options.main_file).rsplit('.', 1)[0], options.format)

  zip_root = options.pkg_dir
  if not os.path.isdir(zip_root):
    sys.exit('source must be a directory')

  # This will write data into the pkg_dir destructively.
  if options.system_module:
    prepare_sys_packages(options.system_module, options.pkg_dir)
    
  bootstrap_src = mkbootstrap()
  log_debug('\n'.join(['%03d  %s' % (i+1, line) for (i, line) in enumerate( bootstrap_src.split('\n'))]))

  with open(options.main_file) as f:
    main_src = f.read()        
  with open(os.path.join(zip_root, '__main__.py'), 'w') as f:
    f.write(bootstrap_src)
  with open(os.path.join(zip_root, '__run__.py'), 'w') as f:
    f.write(main_src)

  zipdata = zipdir(zip_root, args, options)

  if options.format == 'pyc':
    bootstrap_code = compile(bootstrap_src, '<plink bootstrap>', 'exec')
    code = compile_pymagic + marshal.dumps(bootstrap_code) + zipdata
  elif options.format == 'par':
    code = '#!%s\n' % options.python_binary + zipdata

  with open(options.output, 'w') as f:
    f.write(code)

  os.chmod(options.output, 0755)
