#!/usr/bin/env python

from distutils.core import setup

desc = '''
Link a python source tree into a single self-executing zip archive.

It makes embedded C extensions loadable by extracting .so files to disk
on demand. The zip input is staged and then compressed. The plink bootstrap
module is embedded as __main__.py and the actual main module is copied to
__run__.py. The result is an executable zip archive similar to Java JAR file.

plink --main-file <main source file> --pkg-dir <src directory>

PLINK_DEBUG=1 ./main-module.par
'''

setup(
  name='plink',
  version='0.2',
  description='Link a python source tree into a single self-executing zip archive.',
  author='Mike Solomon',
  author_email='<mas63 at cornell dot edu>',
  py_modules=['plink'],
  long_description=desc,
  license='BSD',
  classifiers=[
    'Development Status :: 4 - Beta',
    'Environment :: Console',
    'Intended Audience :: Developers',
    'License :: OSI Approved :: BSD License',
    'Natural Language :: English',
    'Programming Language :: Python',
    'Topic :: Software Development :: Build Tools',
  ],
)
