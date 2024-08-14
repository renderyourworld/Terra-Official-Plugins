echo "Installing $1"
echo $2
installers=/tmp/deadline10_installers
#wget -q -O /tmp/Deadline-10.3.2.1-linux-installers.tar "$1"
chmod +x /tmp/Deadline-10.3.2.1-linux-installers.tar
mkdir -p $installers
tar -xvf /tmp/Deadline-10.3.2.1-linux-installers.tar -C $installers
ls -la $installers
mkdir -p /apps/deadline10/client

chmod +x $installers/DeadlineClient-10.3.2.1-linux-x64-installer.run
$installers/DeadlineClient-10.3.2.1-linux-x64-installer.run \
      --debuglevel 4 \
      --mode unattended \
      --prefix /apps/deadline10/client \
      --repositorydir /apps/deadline10/repository \
      --connectiontype Direct

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/deadline.ini" /apps/deadline10/client
chmod -R 777 /apps/deadline10/client

ls /apps/deadline10/client