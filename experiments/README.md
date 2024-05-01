# Reproducing the Experiments and Analysis of the Paper
Before running the analysis notebooks:
1. unzip the three zip files within this folder (callgraph_seq.zip, pycg_output.zip, DynaPyt_callgraphs.zip).
2. create a Python virtual environement (Use Python 3.10 or above)
    ```shell
    python3.10 -m venv .venv
    source .venv/bin/activate
    ```
3. Install requirments
    ```shell
    pip install -r requirements.txt
    ```
## 1. DyPyBench Overview (Sec3)
You can reproduce the plots of the overview of the benchmark by running the notebook: [dypybench_overview_plots.ipynb](./dypybench_overview_plots.ipynb)

## 2. Call Graphs (Sec4.1)
In this part we generate Dynamic Call Graphs using DynaPyt and we also generate Static Call Graphs using PyCG, then we compare them.

### Step 1. Generating Dynamic Call Graphs
To generate a dynamic call graph for a project (e.g, project 1), the following commands should be executed (note that it takes on average around 4 Hours to complete the generation per project, so run carefully)

```shell
# Run test (necessary to setup the project)
python3 dypybench.py --test 1

# Run instrumentation
python3 dypybench.py --dynapyt_instrument 1 --dynapyt_file ./text/includes.txt --dynapyt_analysis CallGraph

# Run the analysis
python3 dypybench.py --dynapyt_run 1 --dynapyt_analysis CallGraph
```
Once the the commands finished executed, a json file would appear under the project folder (~/temp/project1).

### Step 2. Generating Static Call Graphs
To generate a static call graph for a given project, run the following commands (For documentation, check: https://github.com/vitsalis/PyCG):
```shell
# Run test (necessary to setup the project)
python3 dypybench.py --test 1

# call PyCG
pycg --package project1 $(find project1 -type f -name "*.py") -o project1.json
```
### Step 3. Parsing the generated files and analysing the call graphs
The analysis of callgraphs was done in the notebook: [callgraphs.ipynb](./callgraphs.ipynb)

## LExecutor (Sec4.2)

### Step 1. Generate LExecutor traces

```shell
# Run LExecutor instrumentation
python3 dypybench.py --lex_instrument 1 --lex_file ./text/includes.txt

# Generate Traces
python3 dypybench.py --lex_test 1
```
A ".h5" file would be generate within the project folder.

### Step 2. Retraining LExecutor
To retrain LExector, follow the instruction of the [LExecutor repository](https://github.com/michaelpradel/LExecutor/).

The plot presented in the paper can reproduced by calling the Python script: [generate_lexecutor_acc.py](./generate_lexecutor_acc.py)

## Mining Specs (Sec4.3)

### Step 1: Generate Sequences of API calls
Example on project 1.

```shell
# Run test (necessary to setup the project)
python3 dypybench.py --test 1

# Run instrumentation
python3 dypybench.py --dynapyt_instrument 1 --dynapyt_file ./text/includes.txt --dynapyt_analysis CallGraphSeq

# Run the analysis
python3 dypybench.py --dynapyt_run 1 --dynapyt_analysis CallGraphSeq
```
### Step 2: Patterns Mining
The specification mining is done in the notebooks: [spec_mine.ipynb](./spec_mine.ipynb) and [plots_sec4.3.ipynb](./plots_sec4.3.ipynb)
