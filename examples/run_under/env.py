#!/usr/bin/python
import subprocess
import sys

def main():
    if len(sys.argv) == 1:
        return
    command = sys.argv[1:]
    print("Running " + " " .join(command))
    subprocess.check_call(command)

if __name__ == '__main__':
    main()
