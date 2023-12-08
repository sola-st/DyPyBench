#!/usr/bin/bash

ROOT_DIR=/DyPyBench

cd $ROOT_DIR

#update the LExecutor source from the forked repo.
if [[ ! -d $ROOT_DIR/LExecutor ]]
then
    git clone https://github.com/michaelpradel/LExecutor.git $ROOT_DIR/LExecutor
    cd $ROOT_DIR/LExecutor

    #create virtual env name vm
    virtualenv .vm
else
    cd $ROOT_DIR/LExecutor
    git pull
fi

#activate virtual env
if [[ -d ".vm/local" ]]
then
    source .vm/local/bin/activate
elif [[ -d ".vm/bin" ]]
then
    source .vm/bin/activate
else
    echo "Unable to create virtual env"
    exit
fi

pip install -r ./requirements.txt
pip install -e .

#deactivate .vm
deactivate

