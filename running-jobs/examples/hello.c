#include <mpi.h>
#include <omp.h>
#include <stdio.h>

int main(int argc, char** argv) {
    MPI_Init(NULL, NULL);

    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    int world_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);

    int nthreads, tid;

#pragma omp parallel private(nthreads, tid)
  {
    tid = omp_get_thread_num();
    nthreads = omp_get_num_threads();

    printf("Hello world from processor %s, rank %d out of %d processors, "
           "and here within from thread %d out of %d threads\n",
           processor_name, world_rank, world_size, tid, nthreads);
  } 

    MPI_Finalize();
}

