# DyPyBench
The first benchmark of Python projects that is large-scale, diverse, ready-to-run (i.e., with fully configured and prepared test suites), and
ready-to-analyze (i.e., using an integrated Python dynamic analysis framework). The benchmark encompasses
50 popular open-source projects from various application domains, with a total of 681K lines of Python code,
and 30K test cases.


## Ready-to-Use Docker Image of DyPyBench
**Important Note**

A quick way to use DyPyBench is to download one of our images from DockerHub or ZenoDo (see instructions below); then login to the docker image.

A good practice is to always **start by running the test cases for each project**. This will create a folder for the project under ~/temp/projectN and will have all the installed dependencies and configuration.

For any downstream task, use the projects folders under ~/temp that are created after running the test cases.
### Requirements
    To use our shared image of dypybench, you need to have the following requirements:
    - Docker >= 20.10

### Fetching the image from DockerHub
1. Pull the docker image from dockerhub [<img src="https://img.shields.io/badge/dockerhub-DyPyBench-blue.svg?logo=Docker">](https://hub.docker.com/r/islemdockerdev/dypybench)
    - docker pull docker pull islemdockerdev/dypybench:v2.0
2. Run the docker image to start the container
    - docker run -itd --name dypybench islemdockerdev/dypybench:v2.0
3. Login to the container
    - docker start -i dypybench

### Patching mechanism:
Due to the substantial size of the image (55GB), uploading a new image for minor changes is impractical. Consequently, we propose implementing a patching mechanism as follows:

- Patches addressing specific issues will appear in the "Releases" section of this repository; they will be provided as zip files.
    
- Copy the patch zip file into the Docker container and proceed to unzip it

    ```bash
    # Copy the patch to the docker image
    docker cp patch_XX.zip dypybench:/DyPyBench
    # Inside your docker, in the directory /DyPyBench run this command
    unzip patch_XX.zip
    ```
    
- Execute the command "python3.10 patch_XX.py" within the container, replacing "patch_XX.py" with the accurate script name obtained after unzipping the patch.
    ```bash
    # move to the patch directory
    cd patch_XX
    # execute the patch script
    python3.10 patch_XX.py
    ```

### The list of important patches:
* [patch_2.1](https://github.com/sola-st/DyPyBench/releases/tag/v2.1.0)

## DyPyBench usage manual
Here is a list of the most useful commands of DyPyBench.

1. List the projects setup in DyPyBench
    - python3 dypybench.py --list
2. Run Test Suites of one or more available projects
    - python3 dypybench.py --test 1 2 3 4
2. Run DynaPyt Instrumentation
    - python3 dypybench.py --dynapyt_instrument 1 2 3 4 --dynapyt_file ./text/includes.txt --dynapyt_analysis TraceAll
3. Run DynaPyt Analysis
    - python3 dypybench.py --dynapyt_run 1 2 3 4 --dynapyt_analysis TraceAll
4. Run LExecutor Instrumentation
    - python3 dypybench.py --lex_instrument 1 2 3 4 --lex_file ./text/includes.txt
5. Run tests to generate LExecutor trace
    - python3 dypybench.py --lex_test 1 2 3 4
6. Run PyCG
    - python3 dypybench.py --pycg 1 2 3 4
7. Update DynaPyt source code
    - python3 dypybench.py --update_dynapyt_source
8. Update LExecutor source code
    - python3 dypybench.py --update_lex_source


Here is the list of all available flags that you can use with each command.
### Available flags
1. --list / -l 
    - List the projects
2. --test / -t
    - Specify projects for test
3. --dynapyt_instrument / -di
    - Specify projects for DynaPyt instrumentation
4. --dynapyt_run / -dr
    - Specify projects for DynaPyt analysis 
5. --dynapyt_file / -df
    - Specify path of includes.txt file for DynaPyt instrumentation
6. --dynapyt_analysis / -da
    - Specify name of the DynaPyt analysis to run
7. --save / -s
    - Specify the file to save output
8. --test_original / -to
    - Run tests on code present in original folder
9. --update_dynapyt_source
    - Get or update DynaPyt source code
10. --update_lex_source
    - Get or update LExecutor source code
11. --lex_instrument / -li
    - Specify the project no. to run LExecutor instrumentation
12. --lex_file / -lf
    - Specify the path to file containing the includes.txt file to run LExecutor instrumentation
13. --lex_test / -lt
    - Specify the project no. to run LExecutor for trace generation
14. --timeout
    - Specify timeout to be used in seconds for running test suite and analysis, default is 600 seconds
15. --pycg / -scg
    - Specify project to generate static call graphs using PyCG

### Structure of includes.txt for DynaPyt
    - proj_name flag path
        - proj_name: Project name for which the entry belongs to
        - flag: d for directory path or f for file path
        - path: path of the file/directory to instrument from the root of the project

### Structure of includes.txt for LExecutor
    - proj_name path
        - proj_name: Project name for which the entry belongs to
        - path: path of the file to instrument from the root of DyPyBench


## How to copy files from and to the Docker container?

1. Using volume to map local directory to container directory
    - Start the container with the --volume flag and provide full folder paths
        - docker run -itd --volume local_folder:container_folder --name dypybench dypybench/dypybench:v1.0
2. Copy files or folders individually from running container to local machine
    - docker cp container_name:container_path local_path 
3. Copy files or folders individually to running container from local machine
    - docker cp local_path container_name:container_path


## Build DyPyBench from Scratch
### Requirements
    - Python >= 3.8
    - pip >= 22.0
    - python3-virtualenv >= 20.16.6
    - ffmpeg (project requirement)
    - libjpeg8-dev (project requirement)
    - libavcodec-extra (project requirement)
    - Git >= 2.34
    - Docker >= 20.10

### Steps
1. Clone DyPyBench Repository
    - git clone this repo
2. Build docker image using docker build command
    - docker build -t dypybench .
3. Run the created docker image to start the container
    - docker run -itd --name dypybench dypybench
4. Login to the docker container and execute the bash scripts.
    - docker start -i dypybench
    - ./scripts/install-all-projects.sh > install.log 2>&1