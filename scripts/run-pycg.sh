#!/usr/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}

echo "Running PyCG on $1"

#current working directory
ROOT_DIR=/DyPyBench

cd $ROOT_DIR

#create and change to temp folder
if [[ ! -d "temp" ]]
then
    mkdir "temp"
fi

cd "temp"

if [[ -d "project$2" ]]
then
    rm -rf "project$2"
fi

#make dir for project
mkdir "project$2"

#copy project folder to temp folder
cp -r "$ROOT_DIR/../Project/project$2" ./project$2

cd "project$2"

mv "project$2/.vm" .vm

#activate virtual env
if [[ -d ".vm/local" ]]
then
    source .vm/local/bin/activate
elif [[ -d ".vm/bin" ]]
then
    source .vm/bin/activate
else
    echo "Unable to activate virtual env"
    exit
fi

#install dynapyt dependencies
pip install pycg

#cd project$2

#run pycg
if [[ $4 == "file" ]]
then
    timeout -k 10s $5 pycg --package ./project$2 project$2/$3 -o pycg_$2.json
elif [[ $4 == "folder" ]]
then
    timeout -k 10s $5 pycg --package ./project$2 $(find project$2/$3 -type f -name "*.py") -o pycg_$2.json
    #pycg --package . $(find $3 -type f -regex "(test_.*\.py|.*_test\.py)") -o pycg_$2.json
fi

#deactivate vm
deactivate