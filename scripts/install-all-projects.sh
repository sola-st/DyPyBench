#!/usr/bin/bash

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%T.%3N%z" # current time
}
echo "Setup and Install Python projects and their test suites"

#root directory
ROOT_DIR=/DyPyBench
echo "ROOT_DIR is $ROOT_DIR"

cd $ROOT_DIR

#echo "Please provide the complete location of url file"
#read URL_FILE
URL_FILE=$ROOT_DIR/text/github-url.txt

# Create project folder to keep all the projects together inside one parent folder
PROJ_DIR=$ROOT_DIR/../Project
#if folder already present, then delete the folder
if [[ -d "$PROJ_DIR" ]]
then
    rm -rf "$PROJ_DIR" 
fi

#create directory
mkdir -p "$PROJ_DIR"
cd "$PROJ_DIR"

#WORK_DIR=$(pwd)

#run a while loop to create .vm for all projects
idx=1
while read line
do
    echo $line

    parts=($line)
    URL=${parts[0]}
    FLAGS=${parts[1]}

    echo "\n--------------Setup Start Time--------------\n" 
    timestamp
    echo "\n--------------Setup Start Time--------------\n"

    #change to working directory
    cd $PROJ_DIR
    #create directory for project
    mkdir -p "project$idx"
    #clone the repo to project directory
    git clone "$URL" "project$idx"
    #go into the project directory
    cd "project$idx"
    #check the git log for last commit on given date
    #state of the projects was exported with a default date(2023-01-18), if you change this date projects might no longer function properly due to code changes in the repository.
    CHECKOUT_ID=$(git log -n 1 --until=2023-01-18 --format="%H")
    #checkout the project to this date
    git checkout $CHECKOUT_ID
    #create virtual env name .vm
    virtualenv .vm
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

    #install using pip install . 
    echo "Running pip install ."
    pip install .

    if [[ $FLAGS == "r" || $FLAGS == "rt" ]]
    then
        REQ_FILE=${parts[2]}
        if [[ $URL == "https://github.com/spotify/dh-virtualenv.git" ]]
        then
            sed -i.bak '0,/invoke==0.13.0/s//invoke/' dev-requirements.txt  #fix for dependency conflict issue
        fi
        echo "Running pip install requirements"
        pip install -r $REQ_FILE
    fi

    #some projects need extra requirements for running test suites
    if [[ $URL == "https://github.com/lorien/grab.git" ]]
    then
        pip install cssselect pyquery pymongo fastrq #required for running tests
    elif [[ $URL == "https://github.com/psf/black.git" ]]
    then
        pip install aiohttp #required for running tests
    elif [[ $URL == "https://github.com/errbotio/errbot.git" ]]
    then
        pip install mock #required for running tests
    elif [[ $URL == "https://github.com/PyFilesystem/pyfilesystem2.git" ]]
    then
        pip install parameterized pyftpdlib psutil #required for running tests
    elif [[ $URL == "https://github.com/wtforms/wtforms.git" ]]
    then
        pip install babel email_validator #required for running tests
    elif [[ $URL == "https://github.com/geopy/geopy.git" ]]
    then
        pip install docutils #required for running tests
    elif [[ $URL == "https://github.com/gawel/pyquery.git" ]]
    then
        pip install webtest #required for running tests
    elif [[ $URL == "https://github.com/elastic/elasticsearch-dsl-py.git" ]]
    then
        pip install pytz #required for running tests
    elif [[ $URL == "https://github.com/marshmallow-code/marshmallow.git" ]]
    then
        pip install pytz simplejson #required for running tests
    elif [[ $URL == "https://github.com/pytest-dev/pytest.git" ]]
    then
        pip install hypothesis xmlschema #required for running tests
    fi

    #install pytest library
    pip install pytest

    #install dynapyt
    #pip install dynapyt libcst pytest pytest-xdist aiopg

    echo "\n--------------Setup End Time--------------\n"
    timestamp
    echo "\n--------------Setup End Time--------------\n"

    ((idx++))
    deactivate

done < "$URL_FILE"


# overwrite test files
python3 "$ROOT_DIR/utils/overwrite-test-files.py"