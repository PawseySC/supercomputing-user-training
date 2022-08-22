#!/bin/bash -l
#SBATCH --job-name=first_job
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

# print date and time
echo "The date is: $(date)"

# print host name multiple times
# wait 15 seconds in between
for i in $(seq 1 6); do
   echo "The hostname is: $(hostname)"
   sleep 15s
done

# print date and time again
echo "The date is: $(date)"

