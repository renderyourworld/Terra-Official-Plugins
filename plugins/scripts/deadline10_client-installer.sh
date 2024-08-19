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
cp -v "$SCRIPT_DIR/deadline.ini" $2/client/deadline.ini

# permissions
chmod -R 777 $2/client

# cleanup
echo "Cleaning up ..."
rm -rf $installers
