import argparse
import subprocess
import os

parser = argparse.ArgumentParser()
parser.add_argument(
    "--input_dir", "-d", type=str, help="Specify input directory", default="/DyPyBench/temp")
parser.add_argument(
    "--output_dir", "-r", type=str, help="Specify output directory", default="/DyPyBench/PyCG_output")

def get_files(dir1, dir2):
    files = []
    dir_contents = os.listdir(dir1)
    for content in dir_contents:
        path = os.path.join(os.path.abspath(dir1), content)
        if os.path.isdir(path):
            get_files(path, dir2)
        elif path[-5:] == ".json":
            if path.__contains__('pycg_'):
                command = 'cp ' + path + ' ' + dir2 + '/'
                print(command)
                output = subprocess.run([command
                    ], shell=True, stderr=subprocess.STDOUT)
            
if __name__ == '__main__':
    args = parser.parse_args()
    get_files(args.input_dir, args.output_dir)