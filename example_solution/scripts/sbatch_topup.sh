#!/bin/bash
#SBATCH --mail-type=ALL 			# Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=First.Last@uconn.edu	# Your email address
#SBATCH --nodes=1					# OpenMP requires a single node
#SBATCH --ntasks=1					# Run a single serial task
#SBATCH --cpus-per-task=2           # Number of cores to use
#SBATCH --mem=4096mb				# Memory limit
#SBATCH --time=04:00:00				# Time limit hh:mm:ss
#SBATCH -e error_%A_%a.log				# Standard error
#SBATCH -o output_%A_%a.log				# Standard output
#SBATCH --job-name=topup			# Descriptive job name
#SBATCH --partition=serial			# Use a serial partition 24 cores/7days

export OMP_NUM_THREADS=2			#<= cpus-per-task
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=2	#<= cpus-per-task
##### END OF JOB DEFINITION  #####

#Define user paths
NETID=$USER
PROJECT=hw4

export DIR_BASE=/scratch/${NETID}/${PROJECT}
export DIR_RESOURCES=${DIR_BASE}/resources 	#ro
export DIR_DATA=${DIR_BASE}/data 				#rw data
export DIR_DATAIN=/scratch/birc_ro/ibrain_dwi/100206			#ro data
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

./burc_wrapper.sh run_topup.sh
