#!/bin/bash
job=$(squeue -h | wc -l)
t=$(date)
count=1
if [ $job -gt 0 ] 
    then
        echo "${t} Loss of power. Shutting down." > ABORT

fi 

while [ $job -gt 0] && [ $count -lt 11 ]
    do 
        job=$(squeue -h | wc -l)
        ((count+=1))
        sleep 60
    done
if [ $job -lt 0 ]
    then 
        shutdown now
else
    jobID=$(squeue -h | awk {{print $1}})
    sudo scancel $jobID
    sleep 30
    shutdown now