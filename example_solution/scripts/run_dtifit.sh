#!/bin/bash

#Fit a tensor model
#Assume the preprocessed inputs are in /bind/data_out

cd /bind/data_out
dtifit -k corrected -m brain_mask -r corrected.eddy_rotated_bvecs -b bvals -o dti



