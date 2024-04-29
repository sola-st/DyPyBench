# Quick Install and Run
More details can be found in the main README file.

For this quick setup to run, you need to have Docker >= 20.10 on your machine with at least 110 GB disk space available (and some patience).

1. Pull the docker image from dockerhub [<img src="https://img.shields.io/badge/dockerhub-DyPyBench-blue.svg?logo=Docker">](https://hub.docker.com/r/islemdockerdev/dypybench)
    - docker pull islemdockerdev/dypybench:v2.0
2. Run the docker image to start the container
    - docker run -itd --name dypybench islemdockerdev/dypybench:v2.0
3. Login to the container
    - docker start -i dypybench

4. python3 dypybench.py --test 1