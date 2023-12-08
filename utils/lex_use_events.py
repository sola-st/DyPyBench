import pandas as pd
import csv
import re

use_events = {}
total = 0

with open('/DyPyBench/traces.txt', 'r') as f:
    trace_file = csvReader = csv.reader(f, delimiter="\n")
    for row in csvReader:
        trace_data = pd.read_hdf(str(row[0]))        
        g = re.findall("project[\d]?[\d]", str(row[0]))
        if g[0] in use_events.keys():
            use_events[g[0]] = use_events[g[0]] + trace_data.shape[0]
        else:
            use_events[g[0]] = trace_data.shape[0]
        total += trace_data.shape[0]
        
with open('/DyPyBench/lex_unique_use_events.csv', 'a') as f:
    for key, val in use_events.items():
        f.write(key.replace('project', ''))
        f.write(',')
        f.write(str(val))
        f.write('\n')