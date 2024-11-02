import os
import glob

def get_dirs(path):
    for dir in sorted(os.listdir(path)):
        if os.path.isdir(os.path.join(path, dir)):
            yield dir

def get_files(path):
    for file in sorted(glob.glob(path + '/*.v')):
        if os.path.isfile(os.path.join(file)):
            yield file

def main():
    for dir in get_dirs('.'):
        print(dir, ':', sep='')
        for file in get_files(dir):
            print('\t', file, sep='')

if __name__ == '__main__':
    main()