#!/usr/bin/bash


# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}

echo "Running test suite of $1 for LExecutor"

ROOT_DIR=/DyPyBench

cd $ROOT_DIR

if [[ ! -d "temp/project$2" ]]
then
    #check if project is instrumented
    echo "Please instrument the project first for running tests using LExecutor"
    exit
fi

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

pip install -r $ROOT_DIR/LExecutor/requirements.txt
pip install -e $ROOT_DIR/LExecutor/

echo "\n--------------Test Time Start--------------\n"
timestamp
echo "\n--------------Test Time Start--------------\n"

if [[ $1 == "scikit-learn" ]]
then
    timeout -k 10s $4 pytest --import-mode=importlib $3 #tests for scikit-learn need importlib to locate conftest
else
    timeout -k 10s $4 pytest $3
fi

echo "\n--------------Test Time End--------------\n"
timestamp
echo "\n--------------Test Time End--------------\n"

#deactivate .vm
deactivate