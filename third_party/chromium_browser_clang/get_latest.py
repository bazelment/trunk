#!/usr/bin/python3 -u

'''Download the prebuilt clang binary built by chromium and is used by chromium.'''

import os
import os.path
import subprocess

UPDATE_SH_URL = 'https://chromium.googlesource.com/chromium/src/+/master/tools/clang/scripts/update.sh'
CLANG_REVISION = 238013
CLANG_SUB_REVISION = 1
CDS_URL = 'https://commondatastorage.googleapis.com/chromium-browser-clang'

def get_revision():
    '''Get the revision based encoded in chrome.sh'''
    # TODO: we need to get the raw output or try to parse the HTML output
    update_sh = subprocess.check_output(['curl', UPDATE_SH_URL],
                                        stderr=subprocess.DEVNULL,
                                        universal_newlines=True)
    revision = None
    sub_revision = None
    for line in update_sh.split('\n'):
        print('==' + line)
        if line.find('CLANG_REVISION') == 0:
            revision = line.split('=')
        elif line.find('CLANG_SUB_REVISION') == 0:
            sub_revision = line.split('=')
            break
    return revision, sub_revision


def main():
    url = CDS_URL + '/Linux_x64/clang-%d-%d.tgz' % (CLANG_REVISION, CLANG_SUB_REVISION)
    output_dir = os.path.join(os.path.dirname(__file__), 'Linux_x64')
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    print('Downloading %s to %s' % (url, output_dir))
    subprocess.check_call(['curl %s |tar zx -C %s' % (url, output_dir)],
                          shell=True)


if __name__ == '__main__':
    main()

    
    
