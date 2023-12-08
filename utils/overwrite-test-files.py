import subprocess
import csv
import os

def setupProjects():
    global data
    global original_data
    data = []
    original_data = []
    with open("/DyPyBench/text/github-url.txt", "r") as csv_file:
        csvReader = csv.reader(csv_file, delimiter=" ")
        for index, row in enumerate(csvReader):
            temp=[]
            temp.append(index + 1)
            temp.append(row[0].split("/")[-1].split(".git")[0])
            temp.append(row[0])
            data.append(temp)
            original_data.append(row)

def get_project_name(proj_no):
    for value in data:
        no, name, url = value
        if(proj_no == no):
            return name

def get_project_no(proj_name):
    for value in data:
        no, name, url = value
        if(proj_name == name):
            return str(no)


if __name__ == '__main__':

    setupProjects()
    path = '/DyPyBench/overwrite_files'
    override_folder = os.listdir(path)

    for dir in override_folder:
        p1 = os.path.join(path, dir) 
        p2 = '/DyPyBench/../Project/project' + get_project_no(dir)
        command = 'cp -r ' + p1 + '/. ' + p2 + '/.'
        print(command)
        output = subprocess.run([command
            ], shell=True, stderr=subprocess.STDOUT)
