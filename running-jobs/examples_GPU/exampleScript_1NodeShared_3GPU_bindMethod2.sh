#!/bin/bash --login
#SBATCH --job-name=3GPUSharedNode-bindMethod2
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
#First "aux technique": create a selectGPU wrapper to be used for
#                       binding only 1 GPU per each task spawned by srun
#                       Here we use ROCR_VISIBLE_DEVICES environment variable for this purpose
#                       but, depending on the type of application, some other variables may need to be set too
#                       (check documentation).
wrapper="selectGPU_${SLURM_JOBID}.sh"
cat << EOF > $wrapper
#!/bin/bash

export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
exec \$*
EOF
chmod +x ./$wrapper

#----
#Second "aux technique": generate an ordered list of CPU-cores (each on a different slurm-socket)
#                        to be matched with the correct GPU in the srun command using --cpu-bind option.
#                        Script "generate_CPU_BIND.sh" serves this purpose. This script is available
#                        to all users through the module pawseytools, which is loaded by default.
CPU_BIND=$(generate_CPU_BIND.sh map_cpu)
lastResult=$?
if [ $lastResult -ne 0 ]; then
   echo "Exiting as the map generation for CPU_BIND failed" 1>&2
   rm -f ./$wrapper #deleting the wrapper
   exit 1
fi
echo -e "\n\n#------------------------#"
echo "The chosen CPU_BIND is:"
echo "CPU_BIND=$CPU_BIND"

#----
#MPI & OpenMP settings
export MPICH_GPU_SUPPORT_ENABLED=1 #This allows for GPU-aware MPI communication among GPUs
export OMP_NUM_THREADS=1           #This controls the real CPU-cores per task for the executable

#---------------------- Execution -----------------
#----
#Execution
##Note: srun needs the explicit indication full parameters for use of resources in the job step.
#      These are independent from the allocation parameters (which are not inherited by srun)
echo -e "\n\n#------------------------#"
echo "Test code execution:"
srun -l -u -N 1 -n 3 -c 8 --gpus-per-node=3 --cpu-bind=${CPU_BIND} ./$wrapper ${theExe} | sort -n

#----
#Printing information of finished job steps:
echo -e "\n\n#------------------------#"
echo "Printing information of finished jobs steps using sacct:"
sacct -j ${SLURM_JOBID} -o jobid%20,Start%20,elapsed%20

#----
#Deleting wrappers
rm -f ./$wrapper #deleting the wrapper of the first auxiliary technique for "manual" binding

#----
#Done
echo -e "\n\n#------------------------#"
echo "Done"
