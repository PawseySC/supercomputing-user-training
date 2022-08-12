#!/bin/bash
  
awk '{

if($1==24){nod=$1;ref=$6;refTime=$1*$6} 
{print $1,$6,ref/$6,ref/$6*nod/$1*100,$1*$6/refTime}

}' timing-data >scaling-data
