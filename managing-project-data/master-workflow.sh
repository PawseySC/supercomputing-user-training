#!/bin/bash

stage_job_id=$(sbatch --parsable \
               step1-stage-data.sh \
               | cut -d ";" -f 1)

process_job_id=$(sbatch --parsable \
                 --dependency=afterok:$stage_job_id \
                 step2-process-data.sh \
                 | cut -d ";" -f 1)

store_job_id=$(sbatch --parsable \
               --dependency=afterok:$process_job_id \
               step3-store-data.sh \
               | cut -d ";" -f 1)

exit
