#!/bin/bash
set -e
mono --version
ulimit -u unlimited
source DESTINATION/service/deadline_env.sh
export DEADLINE_PATH=DESTINATION/client
export DEADLINE_CUSTOM_PATH=TERA_CUSTOMPATH
echo "----------------------------------------------------"
echo "Starting up Terra service for: Deadline10 Webservice"
echo "----------------------------------------------------"
mkdir -p /var/lib/Thinkbox/
mkdir -p /var/lib/Thinkbox/Deadline10
cp -v $TERRA_DEADLINE_PATH/service/deadline.ini /var/lib/Thinkbox/Deadline10/deadline.ini
cd $TERRA_DEADLINE_PATH/client/bin
./deadlinewebservice.exe
echo "Terra service for Deadline10 Webservice is running"
# sh -c tail -f /dev/null
