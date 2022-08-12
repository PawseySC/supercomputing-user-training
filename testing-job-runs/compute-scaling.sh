#!/bin/bash

input="timing-data"
output="scaling-data"

echo "# Cores Walltime[s] Relative_Walltime Speedup Efficiency Cost" >$output

awk '{
  if($1==24){nod=$1;ref=$6;refTime=$1*$6} 
  {print $1,$6,$6/ref,ref/$6,ref/$6*nod/$1*100,$1*$6/refTime}
}' $input >>$output

exit
