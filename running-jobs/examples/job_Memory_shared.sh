#!/bin/bash --login

#SBATCH --output=%x.out
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-socket=1
#SBATCH --distribution=block:block:block
#SBATCH --cpus-per-task=1
#SBATCH --mem=58G
#SBATCH --time=00:01:00

srun ./hello.x
