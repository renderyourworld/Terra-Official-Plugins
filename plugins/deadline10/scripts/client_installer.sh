installers=/apps/tmp/deadline10_installers
echo "Installing Deadline 10 Client from $installers to $1"

# permissions
chmod +x $installers/DeadlineClient-*-linux-x64-installer.run

# install the client
$installers/DeadlineClient-10.3.2.1-linux-x64-installer.run \
      --debuglevel 4 \
      --mode unattended \
      --prefix $1/client \
      --repositorydir $1/repository \
      --connectiontype Direct

cp -v ./deadline10/deadline.ini $1/client/deadline.ini
cp -v ./assets/deadline10client.png $1/deadline10client.png

cp -v ./deadline10/deadlinelauncher10.desktop $1/deadlinelauncher10.desktop
cp -v ./deadline10/deadlinemonitor10.desktop $1/deadlinemonitor10.desktop
cp -v ./deadline10/deadlineworker10.desktop $1/deadlineworker10.desktop
cp -v ./deadline10/monitor-juno.dmstyle $1/client/monitor-juno.dmstyle

sed -i "s@DESTINATION@$1@g" $1/deadlinelauncher10.desktop
sed -i "s@DESTINATION@$1@g" $1/deadlinemonitor10.desktop
sed -i "s@DESTINATION@$1@g" $1/deadlineworker10.desktop

# setup for polaris to pickup
cp -v "."/deadline10/deadline_client.sh.source $1/deadline_client.sh.source
sed -i "s@DESTINATION@$1@g" $1/deadline_client.sh.source
sed -i "s@TERA_CUSTOMPATH@$3@g" $1/deadline_client.sh.source
chmod +x $1/deadline_client.sh.source

# copy local thinkbox files
mkdir -p $1/client/userdata
cp -r ./deadline10/monitor-juno.dmstyle $1/client/userdata/monitor-juno.dmstyle
chmod -R 777 $1/client/userdata

# permissions
chmod -R 777 $1 > /dev/null
