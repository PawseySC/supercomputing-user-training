#!/bin/bash -l
#SBATCH --job-name=submit_monitor
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00

# print date and time
echo "The date is: $(date)"

# print host name (from the compute node) multiple times
# wait 15 seconds in between
for i in $(seq 1 2); do
   echo "The hostname is: $(hostname)"
   sleep 15s
done

# print date and time again
echo "The date is: $(date)"

