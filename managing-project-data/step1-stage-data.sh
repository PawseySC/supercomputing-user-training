#!/bin/bash -l
#SBATCH --job-name=step1-stage-data
#SBATCH --partition=copy
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=00:01:00

module load miniocli/2022-02-02T02-03-24Z
MY_BUCKET=

if [ -z ${MY_BUCKET} ] ; then
 echo "Please run the script prepare-data.sh first. Exiting."
 exit 1
fi

mc cp ${MY_BUCKET}/input-file .
