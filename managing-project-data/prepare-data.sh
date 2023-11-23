#!/bin/bash

# preliminary steps to get ready for the supercomputing workflow

if [ -z ${MY_BUCKET} ] ; then
 echo "Please export the variable MY_BUCKET appropriately. Exiting."
 exit 1
fi

module load rclone/1.62.2

sed -i "s;MY_BUCKET=.*;MY_BUCKET=${MY_BUCKET};g" step*.sh

echo "Hello from Acacia." >input-file
rclone copy ./input-file ${MY_BUCKET}/
rm input-file
rclone delete ${MY_BUCKET}/output-file

exit
