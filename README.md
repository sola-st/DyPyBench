# DyPyBench
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10683759.svg)](https://zenodo.org/records/10683759)
[<img src="https://img.shields.io/badge/dockerhub-DyPyBench-blue.svg?logo=Docker">](https://hub.docker.com/r/islemdockerdev/dypybench)

The first benchmark of Python projects that is large-scale, diverse, ready-to-run (i.e., with fully configured and prepared test suites), and
ready-to-analyze (i.e., using an integrated Python dynamic analysis framework). The benchmark encompasses
50 popular open-source projects from various application domains, with a total of 681K lines of Python code,
and 30K test cases.

**For more information, check our paper:
https://www.software-lab.org/publications/fse2024_dypybench.pdf**

## 1. Using the Benchmark

Before downloading and using the Docker image of DyPyBench, please check the requirements [here](./REQUIREMENTS.md)

**Important Note:** 

As the image size is 55GB, we could not put it on zenodo because they only allow up to 50GB. 
However, we put scripts to reproduce the paper's experiments and the obtained data on zenodo alongside the scripts required to rebuild DyPyBench from scratch.
zenodo Zip File: https://zenodo.org/records/10683759

### Step 1. Fetching the image from DockerHub

1. Pull the docker image from dockerhub
    - docker pull islemdockerdev/dypybench:v2.0
2. Run the docker image to start the container
    - docker run -itd --name dypybench islemdockerdev/dypybench:v2.0
3. Login to the container
    - docker start -i dypybench

Important complementary Action: **Apply the most recent patch**

Check below on how to do it. (See within this file, the section: 4. Maintainance and Future Support)

### Step 2. Interacting with the Command Line
Here is a list of the most useful commands of DyPyBench.

1. List the projects setup in DyPyBench
    - python3 dypybench.py --list
2. Run Test Suites of one or more available projects
    - python3 dypybench.py --test 1 2 3 4
    - Example: python3 dypybench.py --test 1
2. Run DynaPyt Instrumentation
    - python3 dypybench.py --dynapyt_instrument 1 2 3 4 --dynapyt_file ./text/includes.txt --dynapyt_analysis TraceAll
    - Example: python3 dypybench.py --dynapyt_instrument 1 --dynapyt_file ./text/includes.txt --dynapyt_analysis TraceAll
3. Run DynaPyt Analysis
    - python3 dypybench.py --dynapyt_run 1 2 3 4 --dynapyt_analysis TraceAll
    - Example: python3 dypybench.py --dynapyt_run 1 --dynapyt_analysis TraceAll
4. Run LExecutor Instrumentation
    - python3 dypybench.py --lex_instrument 1 2 3 4 --lex_file ./text/includes.txt
    - Example: python3 dypybench.py --lex_instrument 1 --lex_file ./text/includes.txt
5. Run tests to generate LExecutor trace
    - python3 dypybench.py --lex_test 1 2 3 4
    - Example: python3 dypybench.py --lex_test 1
6. Run PyCG
    - python3 dypybench.py --pycg 1 2 3 4
    - Example: python3 dypybench.py --pycg 1
7. Update DynaPyt source code
    - python3 dypybench.py --update_dynapyt_source
8. Update LExecutor source code
    - python3 dypybench.py --update_lex_source

Alongside the commands above, you can have more control on some commands using the following list of available flags with explanation:

#### Available flags
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
    - Specify timeout to be used in seconds for running test suite and analysis
15. --pycg / -scg
    - Specify project to generate static call graphs using PyCG

#### Useful commands to copy files from and into the Docker image
1. Using volume to map local directory to container directory
    - Start the container with the --volume flag and provide full folder paths
        - docker run -itd --volume local_folder:container_folder --name dypybench dypybench/dypybench:v1.0
2. Copy files or folders individually from running container to local machine
    - docker cp container_name:container_path local_path 
3. Copy files or folders individually to running container from local machine
    - docker cp local_path container_name:container_path

## 2. Reproducing the Experiments of the Paper
For the ones interested, we also provide the notebooks (and intermediate data) used in the analysis presented the overview (Sec3) and analysis (Sec4) sections of our paper. Please find instructions on how to reproduce in [experiments/README.md](experiments/README.md).

General requirements can be found [here](./REQUIREMENTS.md).

Specific Python requirments can be found [here](./experiments/requirements.txt).


## 3. OPTIONAL: Build DyPyBench from Scratch

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

## 4. Maintainance and Future Support
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

### The list of important patches (so far):
* [patch_2.1](https://github.com/sola-st/DyPyBench/releases/tag/v2.1.0)


# Cite us
```bibtex
@InProceedings{fse2024-DyPyBench,
  author    = {Islem Bouzenia and Bajaj Piyush Krishan and Michael Pradel},
  title     = {{DyPyBench}: {A} Benchmark of Executable {Python} Software},
  booktitle = {ACM International Conference on the Foundations of Software Engineering (FSE)},
  year      = {2024},
}
```
