#!/bin/bash

installers="$MOUNT_LOCATION/tmp/deadline10_installers"
echo "Starting Deadline 10 repository installation > $1"

# permissions
chmod +x $installers/DeadlineRepository-*-linux-x64-installer.run

echo "Installing Deadline 10 repository from $installers"

for f in $installers/DeadlineRepository-*-linux-x64-installer.run; do
  # install the repository
  "$f" --debuglevel 4 \
        --installmongodb false \
        --mode unattended \
        --requireSSL false \
        --dbssl false \
        --prefix $1/repository \
        --dbname deadline10db \
        --dbhost deadline-mongo \
        --dbport 27017
        #--setpermissions true
done


echo "Deadline 10 repository installed. Setting up ini files."
# setup the repository
cp -v ./deadline10/webservice-deadline.ini $1/service/deadline.ini
cp -v ./deadline10/deadline-repository-connection.ini $1/repository/settings/connection.ini
cp -v ./deadline10/deadline_env.sh $1/service/deadline_env.sh

echo "Creating default custom deadline path location"
mkdir -p $2
# copy Eva to the custom path
mkdir -p $2/events
chmod +x ./deadline10/eva.tar
tar -xvf ./deadline10/eva.tar -C $1/repository/custom/events > /dev/null

chmod +x $1/service/deadline_env.sh
echo "Deadline 10 repository setup done."

echo "Making repository lighter by removing Windows and Mac binary files"
rm -rfv $1/repository/bin/Mac
rm -rfv $1/repository/bin/Windows

echo "Deadline 10 repository cleanup done."




