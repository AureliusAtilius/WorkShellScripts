#!/bin/bash
job=$(squeue -h | wc -l)
t=$(date)

if [ $job -gt 0 ] 
then
    echo "${t} High Temperature threshold exceeded." > /projects/karem/starccm_projects/simInteraction/ABORT

fi 

