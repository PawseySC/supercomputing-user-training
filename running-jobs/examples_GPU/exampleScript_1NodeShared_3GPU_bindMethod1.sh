#!/bin/bash --login
#SBATCH --job-name=3GPUSharedNode-bindMethod1
#SBATCH --partition=gpu
#SBATCH --nodes=1              #1 nodes in this example 
#SBATCH --gpus-per-node=3      #3 GPUs per node (3 "allocation packs" in total for the job)
#SBATCH --time=00:05:00
#SBATCH --account=<yourProject>-gpu #IMPORTANT: use your own project and the -gpu suffix
#(Note that there is not request for exclusive access to the node)

#----
#Loading needed modules (adapt this for your own purposes):
module load PrgEnv-cray
module load rocm craype-accel-amd-gfx90a
echo -e "\n\n#------------------------#"
module list

#----
#Printing the status of the given allocation
echo -e "\n\n#------------------------#"
echo "Printing from scontrol:"
scontrol show job ${SLURM_JOBID}

#----
#Definition of the executable (we assume the example code has been compiled and is available in $MYSCRATCH):
exeDir=$MYSCRATCH/hello_jobstep
exeName=hello_jobstep
theExe=$exeDir/$exeName

#----
#MPI & OpenMP settings
export MPICH_GPU_SUPPORT_ENABLED=1 #This allows for GPU-aware MPI communication among GPUs
export OMP_NUM_THREADS=1           #This controls the real CPU-cores per task for the executable

#---------------------- Execution -----------------
#----
#Execution
#Note: srun needs the explicit indication full parameters for use of resources in the job step.
#      These are independent from the allocation parameters (which are not inherited by srun)
echo -e "\n\n#------------------------#"
echo "Test code execution:"
srun -l -u -N 1 -n 3 -c 8 --gpus-per-node=3 --gpus-per-task=1 --gpu-bind=closest ${theExe} | sort -n

#----
#Printing information of finished job steps:
echo -e "\n\n#------------------------#"
echo "Printing information of finished jobs steps using sacct:"
sacct -j ${SLURM_JOBID} -o jobid%20,Start%20,elapsed%20

#----
#Done
echo -e "\n\n#------------------------#"
echo "Done"
