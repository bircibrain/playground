#!/bin/bash
#SBATCH --mail-type=ALL 			# Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=First.Last@uconn.edu	# Your email address
#SBATCH --nodes=1					# OpenMP requires a single node
#SBATCH --mem=2048mb				# Memory limit
#SBATCH --time=04:00:00				# Time limit hh:mm:ss
#SBATCH -e error_%A_%a.log				# Standard error
#SBATCH -o output_%A_%a.log				# Standard output
#SBATCH --job-name=bedpostx			# Descriptive job name
#SBATCH --partition=serial			# Use a serial partition 24 cores/7days
#SBATCH --array=0-109

export OMP_NUM_THREADS=1			#<= cpus-per-task
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1	#<= cpus-per-task
##### END OF JOB DEFINITION  #####

#Define user paths
NETID=$USER
PROJECT=martin

export DIR_BASE=/scratch/${NETID}/${PROJECT}
export DIR_RESOURCES=${DIR_BASE}/resources 	#ro
export DIR_DATA=${DIR_BASE}/data 				#rw data
export DIR_DATAIN=${DIR_BASE}/data_in			#ro data
export DIR_DATAOUT=${DIR_BASE}/data_out		#rw data
export SUBJECTS_DIR=${DIR_BASE}/freesurfer		#rw for Freesurfer
export DIR_WORK=/work							#rw /work on HPC is 40Gb local storage
export DIR_SCRATCH=${DIR_BASE}/scratch 		#rw shared storage
export DIR_SCRIPTS=${DIR_BASE}/scripts 		#ro, prepended to PATH


# Load modules
module load matlab/2017a				#matlab binaries are bound
module load singularity/2.3.1-gcc		#required to run the container

#set the matlab license path to the path inside the container
export LM_LICENSE_FILE=/bind/matlablicense/uits.lic

#finally call the container with any arguments for the job
#wrapper will bind the appropriate paths
#environment variables are passed to the container

./burc_wrapper.sh run_bedpost.sh $SLURM_ARRAY_TASK_ID
