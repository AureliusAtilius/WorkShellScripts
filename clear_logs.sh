#!/bin/bash
#Usage= ./clear_logs.sh <Number of days old>
#Script removes folders with the "log directory name" in the base folder that are older than the number of days old taken as an argument
#Copy a log folder to a test directory to test the script first
#script will echo the folders only, uncomment rm to remove when ready 

daysOld=$1
#baseFolder="/production/directory/path/"
baseFolder="/test/directory/path/"

command="find ${baseFolder} -maxdepth 4 -type d -name "log directory name" -mtime +${daysOld}"


echo $command
#rawFolders=( $($command) )


for i in "${rawFolders[@]}"
do
        echo $i
        #rm -Rfi $i
done
