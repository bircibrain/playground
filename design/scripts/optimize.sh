#!/bin/bash
#the number of iterations
N=10
echo "iteration eff seed" > results.txt
#TODO: start a loop in i from 1 to $N
for i in `seq $N`; do
	#portable method of getting a random number
	seed=`cat /dev/random|head -c 256|cksum |awk '{print $1}'`

	#TODO: RSFgen command
	#use -seed $seed
	#-prefix rsf.${i}.

	RSFgen \
	-nt 200 \
	-num_stimts 3 \
	-nreps 1 20 \
	-nreps 2 20 \
	-nreps 3 20 \
	-seed ${seed} -prefix rsf.${i}.

	#TODO: make_stim_times.py command
	#use prefix stim.${i}
	make_stim_times.py \
	-files rsf.${i}.*.1D \
	-prefix stim.${i} \
	-nt 200 \
	-tr 2 \
	-nruns 1


	#TODO: 3dDeconvolve command
	#redirect the output to efficiency.${i}.txt
	3dDeconvolve \
	-nodata 200 2 \
	-polort 1 \
	-num_stimts 3 \
	-stim_times 1 stim.${i}.01.1D 'GAM' \
	-stim_label 1 'A:' \
	-stim_times 2 stim.${i}.02.1D 'GAM' \
	-stim_label 2 'B' \
	-stim_times 3 stim.${i}.03.1D 'GAM' \
	-stim_label 3 'C' \
	-gltsym "SYM: A -B" \
	-gltsym "SYM: A -C" > efficiency.${i}.txt

	eff=`./efficiency_parser.py efficiency.${i}.txt`

	echo "$i $eff $seed" >> results.txt
	#end loop
done
