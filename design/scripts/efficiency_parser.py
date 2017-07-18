#!/usr/bin/env python
import re #regex module
import numpy as np
import sys

#Usage: efficiency_parser.py out.txt
#Parse the output of 3dDeconvole -nodata stored in out.txt

#make a dictionary to store the results
results = {'Contrast': [], 'eff': []}

#TODO: open the 3dDeconvolve output filename stored in sys.argv[1]
#TODO: read all the lines in the file into a string s. 
#Make sure s is a string, not a list

with open(sys.argv[1], 'r') as fd:
	s = fd.read()


#compile the regex
#use re.MULTILINE since we need to match across lines
p = re.compile(r"^.+:\s+(.+)\s+.+=\s+([.0-9]+)", re.MULTILINE)

#find all of the matches in s and return an interator in matches

matches = p.finditer(s)

#TODO: iterate through matches and copy the values to the results dictionary
#for each match, m, you get from the iterator, m.groups() is a tuple
#try m=p.search() to see what the first one looks like
for m in matches:
	values = m.groups()
	results['Contrast'] = results['Contrast'] + [values[0]]
	results['eff'] = results['eff'] + [float(values[1])]

#TODO: calculate the summed efficiency of all the stimulus functions and contrasts (i.e. sum the 'eff' key in the dictionary)
#try np.sum()
eff = np.sum(results['eff'])

#TODO print the summed efficiency
print(eff)

