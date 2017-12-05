#!/bin/bash
cd /bin/data_out/bedpostX
bedpostx_single_slice.sh $1 --nf=2 --fudge=1 --bi=1000 --nj=1250 --se=25 --model=2 --cnonlinear  --rician

