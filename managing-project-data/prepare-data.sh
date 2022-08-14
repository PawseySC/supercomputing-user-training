#!/bin/bash

# preliminary steps to get ready for the supercomputing workflow

if [ -z ${MY_BUCKET} ] ; then
 echo "Please export the variable MY_BUCKET appropriately. Exiting."
 exit 1
fi

module load miniocli/2022-02-02T02-03-24Z

sed -i "s;MY_BUCKET=.*;MY_BUCKET=${MY_BUCKET};g" step*.sh

echo "Hello from Acacia." >input-file
mc cp input-file ${MY_BUCKET}/
rm input-file
mc rm ${MY_BUCKET}/output-file

exit
