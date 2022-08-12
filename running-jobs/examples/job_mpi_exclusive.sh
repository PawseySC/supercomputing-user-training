#!/bin/bash --login

#SBATCH --output=%x.out
#SBATCH --partition=work
#SBATCH --ntasks=256
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --exclusive

srun ./hello.x
