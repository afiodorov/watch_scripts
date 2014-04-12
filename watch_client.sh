#!/bin/bash 

SERVER_URL=localhost
FILE_TO_WATCH=/tmp/appServer_${USER}_restart

function create_rebooted_file {
ssh $SERVER_URL "echo $(date) >$FILE_TO_WATCH"
}

create_rebooted_file
while true; do
	inotifywait -r -e modify,create --exclude=".swp" . && create_rebooted_file
done
