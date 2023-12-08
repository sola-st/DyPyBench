#!/usr/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}

echo "Running test suite of $1"

#current working directory
ROOT_DIR=/DyPyBench

cd $ROOT_DIR

if [[ $4 == "False" ]]
then
    if [[ ! -d $ROOT_DIR/temp ]]
    then
        #create and change to temp folder
        mkdir "temp"
    fi

    cd "temp"

    #copy project folder to temp folder
    cp -r "$ROOT_DIR/../Project/project$2" .

    cd project$2
else
    cd "$ROOT_DIR/../Project/project$2"
fi

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

echo "\n--------------Test Time Start--------------\n"
timestamp
echo "\n--------------Test Time Start--------------\n"

if [[ $1 == "scikit-learn" ]]
then
    timeout -k 10s $5 pytest --import-mode=importlib $3 #tests for scikit-learn need importlib to locate conftest
else
    timeout -k 10s $5 pytest $3
fi

echo "\n--------------Test Time End--------------\n"
timestamp
echo "\n--------------Test Time End--------------\n"

#deactivate .vm
deactivate