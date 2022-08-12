#!/bin/bash --login

#SBATCH --output=%x.out
#SBATCH --partition=work
#SBATCH --ntasks=64
#SBATCH --ntasks-per-node=64
#SBATCH --ntasks-per-socket=64
#SBATCH --distribution=block:block:block
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00

srun ./hello.x
