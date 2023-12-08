#!/usr/bin/bash

echo "Clear temp project directory for $1"

#current working directory
WORK_DIR=/DyPyBench/temp

#check if dir exists else print error and exit
if [[ -d "$WORK_DIR/project$2" ]]
then
    rm -rf "$WORK_DIR/project$2"
else
    echo "Project temp directory does not exist"
    exit
fi
