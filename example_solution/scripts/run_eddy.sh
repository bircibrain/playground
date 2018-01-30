#!/bin/bash
#Run eddy
#Assume the preprocessed inputs are in /bind/data_out
#and original source files are in /bind/data_in
#Multiband factor=3, top slice removed

cd /bind/data_out
eddy_cuda --mask=brain_mask \
--acqp=acqparams.txt \
--index=index.txt \
--imain=merged_dwi_cropped \
--bvecs=bvecs \
--bvals=bvals \
--out=corrected \
--mb=3 \
--mb_offs=1 \
--ol_type=gw \
--cnr_maps \
--repol \
--topup=topup
