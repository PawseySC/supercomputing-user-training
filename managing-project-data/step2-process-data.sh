#!/bin/bash -l
#SBATCH --job-name=step2-process-data
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00

cp input-file output-file
echo "Hello back from Setonix." >>output-file
