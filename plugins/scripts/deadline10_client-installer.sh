installers=/apps/tmp/deadline10_installers
echo "Installing Deadline 10 Client from $installers to $2"

# create client directory
mkdir -p $2/client

# permissions
chmod +x $installers/DeadlineClient-10.3.2.1-linux-x64-installer.run

# install the client
$installers/DeadlineClient-10.3.2.1-linux-x64-installer.run \
      --debuglevel 4 \
      --mode unattended \
      --prefix $2/client \
      --repositorydir $2/repository \
      --connectiontype Direct

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cp -v "$SCRIPT_DIR/deadline10/deadline.ini" $2/client/deadline.ini
cp -v "../assets/deadline10client.png" $2/deadline10client.png

cp -v "$SCRIPT_DIR/deadline10/deadlinelauncher10.desktop" $2/deadlinelauncher10.desktop
cp -v "$SCRIPT_DIR/deadline10/deadlinemonitor10.desktop" $2/deadlinemonitor10.desktop
cp -v "$SCRIPT_DIR/deadline10/deadlineworker10.desktop" $2/deadlineworker10.desktop
cp -v "$SCRIPT_DIR/deadline10/monitor-juno.dmstyle" $2/client/monitor-juno.dmstyle

sed -i "s@DESTINATION@$2@g" $2/deadlinelauncher10.desktop
sed -i "s@DESTINATION@$2@g" $2/deadlinemonitor10.desktop
sed -i "s@DESTINATION@$2@g" $2/deadlineworker10.desktop

# permissions
chmod -R 777 $2 > /dev/null

# cleanup
echo "Cleaning up ..."
rm -rf $installers
