# Requirements to Run DyPyBench
    ## Software
    To use our shared image of dypybench, you need to have the following requirements:
    - Docker >= 20.10

    ## Hardware
    The docker images takes around 55GB of disk space. However after launching the container, it gets decompressed and the size becomes 104 GB. Always intend for at least 110GB of space.

    As everything is containerized within the docker image, DyPyBench does not require any dependencies from the user (Unless they want to customize it by adding their own software, tools...)


# Requirements to Rerun the Three Experiments in our Paper

    ## DynaPyt Call Graphs Generation
    1. It takes around 180 hours to generate all the dynamic call graphs for all the projects within DyPyBench. This was obtained by running on a machine with 16 cores CPU and 64GB of RAM.
    2. The generation happens within the Docker container, so no extra dependencies are needed (DynaPyt is installed within the image and ready to run).
    3. The total size of generated call graphs is less than 10 MB

    ## PyCG Call Graphs Generation
    1. PyCG takes around 83 hours to generate all the static call graphs for all the projects. This was obtained by running on a machine with 16 cores CPU and 64GB of RAM.
    2. the generation happens within the Docker container, so no extra dependencies are needed (PyCG is installed within the image and ready to run).
    3. The total size of generated traces is less than 10 MB.

    ## Generating LExecutor Traces
    1. LExecutor takes around 227 hours to generate execution traces for all the projects. This was obtained by running on a machine with 16 cores CPU and 64GB of RAM.
    2. the generation happens within the Docker container, so no extra dependencies are needed (LExecutor is installed within the image and ready to run).
    3. The total size of generated traces is less than 10 MB.

    ## Training LExecutor Prediction Model
    After generating LExecutor traces, we launch the training part. Instructions on how to train the models are found within the LExector repository (an already published work with artifact available and reusable): https://github.com/michaelpradel/LExecutor
    

    ## Generating Sequences of API Calls
    1. It takes around 74 hours to generate sequences of API calls for 27 projects. This was obtained by running on a machine with 16 cores CPU and 64GB of RAM.
    2. The generation happens within the Docker container, so no extra dependencies are needed (DynaPyt is installed within the image and ready to run).
    3. The total size of generated sequences is less than 100MB

# Requirements to Reproduce the Analysis with Plots
    Using our generated data and analysis notebooks, you can reproduce the results and plots of our analysis.
    ## Data files
    Can be found in our ZenoDo archive or within the release section of this repository

    ## Software
    1. Python3.8 or above
    2. JupyterLab or VScode to run the notebook (any other notebook runner that supports IPyKernel is also possible)
    3. For other python packages requirements, check the file: experiments/requirements.txt

    ## Hardware
    Minimum of 16GB of RAM.