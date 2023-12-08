#!/usr/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}

echo "Running dynapyt analysis on $1"

#current working directory
ROOT_DIR=/DyPyBench

cd $ROOT_DIR

#check if instrumentation is done first
if [[ ! -d temp/project$2 ]]
then
    echo "Please perform instrumentation first"
    exit
fi

#change to project directory
cd "temp/project$2"

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

if [[ $1 == "grab" ]]
then
    #printf "import os\n\nos.system('python $WORK_DIR/temp/project$2/runtest.py --test-all')\n" > run_all_tests.py
    printf "import pytest\n\npytest.main(['--import-mode=importlib', '$ROOT_DIR/temp/project$2/$4'])\n" > run_all_tests.py
else
    printf "import pytest\n\npytest.main(['--import-mode=importlib', '$ROOT_DIR/temp/project$2/$4'])\n" > run_all_tests.py
fi

#run analysis on the given project
timeout -k 10s $5 python -m dynapyt.run_analysis --entry ./run_all_tests.py --analysis $3

#deactivate vm
deactivate