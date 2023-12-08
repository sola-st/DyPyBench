#!/usr/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}

echo "Running LExecutor instrumentation on $1"

ROOT_DIR=/DyPyBench

cd $ROOT_DIR

#create and change to temp folder
if [[ ! -d "$ROOT_DIR/temp" ]]
then
    mkdir "temp"
fi

cd "temp"

if [[ ! -d "project$2" ]]
then
    #copy project folder to temp folder
    cp -r "$ROOT_DIR/../Project/project$2" .
fi

cd project$2

PROJ_DIR=$(pwd)

if [[ -d "$ROOT_DIR/LExecutor" ]]
then
    cd "$ROOT_DIR/LExecutor"
else
    echo "LExecutor not setup!!!!"
    echo "Please setup LExecutor first"
    exit
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

cd $ROOT_DIR

# run instrument for given files or a single .txt file, other arguments can be added later using if else
timeout -k 10s $3 python -m lexecutor.Instrument --files ${@:4} --iids /DyPyBench/iids.json --validate

#deactivate vm
deactivate