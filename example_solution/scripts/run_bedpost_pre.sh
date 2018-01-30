#!/bin/bash
#prepare for bedpost
cd /bind/data_out
mkdir bedpostX
imcp corrected bedpostX/data
imcp brain_mask bedpostX/nodif_brain_mask
cp bvals bedpostX/bvals
cp corrected.eddy_rotated_bvecs bedpostX/bvecs
bedpostx_preproc.sh bedpostX
#make the required directories
mkdir -p bedpostX.bedpostX/logs/monitor
