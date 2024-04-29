# Analysis and Results of the Paper
Before running the analysis notebooks:
1. unzip the three zip files within this folder (callgraph_seq.zip, pycg_output.zip, DynaPyt_callgraphs.zip).
2. create a Python virtual environement (Use Python 3.8 or above)
    ```shell
    python3.8 -m venv .venv
    source .venv/bin/activate
    ```
3. Install requirments
    ```shell
    pip install -r requirments.txt
    ```
## DyPyBench Overview (Sec3)
You can reproduce the plots of the overview of the benchmark by running the notebook: [dypybench_overview_plots.ipynb](./dypybench_overview_plots.ipynb)

## Call Graphs (Sec4.1)
The analysis of callgraphs was done in the notebook: [callgraphs.ipynb](./callgraphs.ipynb)

## LExecutor (Sec4.2)
To retrain LExector, follow the instruction of the original repository.

The plot presented in the paper can reproduced by calling the python script: [generate_lexecutor_acc.py](./generate_lexecutor_acc.py)

## Mining Specs (Sec4.3)
The specification mining is done in the notebooks: [spec_mine.ipynb](./spec_mine.ipynb) and [spec_mine_old.ipynb](./spec_mine_old.ipynb)