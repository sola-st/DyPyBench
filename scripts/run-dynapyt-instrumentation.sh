#!/usr/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}

echo "Running dynapyt instrumentation on $1"

#current working directory
ROOT_DIR=/DyPyBench

cd $ROOT_DIR

#create and change to temp folder
if [[ ! -d "temp" ]]
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

#copy the dynypyt src if needed
if [[ -d "$ROOT_DIR/DynaPyt" ]]
then
    cp -r "$ROOT_DIR/DynaPyt" "./DynaPyt"
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

#install dynapyt dependencies
pip install dynapyt libcst pytest-xdist aiopg
pip install -r ./DynaPyt/requirements.txt

#update dynapyt
if [[ -d ./DynaPyt ]]
then
    pip install ./DynaPyt
else
    echo "Please install DynaPyt first"
    exit
fi

if [[ $5 == "d" ]]
then
    #run instrumentation on the given directory
    timeout -k 10s $6 python -m dynapyt.run_instrumentation --directory $3 --analysis $4
elif [[ $5 == "f" ]]
then
    #run instrumentation on the given file
    timeout -k 10s $6 python -m dynapyt.instrument.instrument --files $3 --analysis $4
fi

#deactivate vm
deactivate