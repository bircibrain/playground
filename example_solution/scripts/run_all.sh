#!/bin/bash
#Run everything
#This script calls the required SLURM submission scripts
#and illustrates the use of job dependencies
#there is a possibility this won't work with afterok. 
#You can try afterany to ignore the job exit status

j_topup=$( sbatch sbatch_topup.sh )
j_eddy=$( sbatch --dependency=afterok:$j_topup sbatch_eddy_mp.sh )
j_dtifit=$( sbatch --dependency=afterok:$j_eddy sbatch_dtifit.sh )
j_bedpostprep=$( sbatch --dependency=afterok:$j_eddy sbatch_bedpost_pre.sh )
j_bedpost=$( sbatch --dependency=afterok:$j_bedpostprep sbatch_bedpost.sh )
sbatch --dependency=afterok:$j_bedpost sbatch_bedpost_post.sh

