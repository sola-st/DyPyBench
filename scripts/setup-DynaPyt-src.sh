#!/usr/bin/bash

ROOT_DIR=/DyPyBench

cd $ROOT_DIR

#update the dynapyt source from the forked repo.
if [[ ! -d DynaPyt ]]
then
    git clone https://github.com/piyush-bajaj/DynaPyt.git $ROOT_DIR/DynaPyt
    cd $ROOT_DIR/DynaPyt
else
    cd $ROOT_DIR/DynaPyt
    git pull
fi

#checkout the lastest code and analysis from the custom branch
git checkout piyush-bajaj-dypybench-analysis
