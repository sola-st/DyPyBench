import argparse
import os
import csv

parser = argparse.ArgumentParser()
parser.add_argument(
    "--dir", "-d", type=str, help="Specify directory")
parser.add_argument(
    "--ext", "-e", type=str, help="Specify extension with .")
parser.add_argument(
    "--replace", "-r", type=str, help="pattern to replace root_dir in path", default=".")

def get_files(dir, ext):
    files = []
    dir_contents = os.listdir(dir)
    for content in dir_contents:
        path = os.path.join(os.path.abspath(dir), content)
        if os.path.isdir(path):
            get_files(path, ext)
        elif path[-3:] == ext:
            if path.__contains__('trace_'):
                with open('traces.txt', 'a') as f:
                    f.write(path.replace(args.dir,args.replace))
                    f.write('\n')
            
if __name__ == '__main__':
    args = parser.parse_args()
    get_files(args.dir, args.ext)
