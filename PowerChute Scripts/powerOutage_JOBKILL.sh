#!/bin/bash
job=$(squeue -h | wc -l)
t=$(date)

if [ $job -gt 0 ] 
then
    echo "${t} Loss of power. Shutting down." > ABORT

fi 

