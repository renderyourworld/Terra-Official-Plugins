echo "Installing $1"
echo $2
installers=/tmp/deadline10_installers
#wget -q -O /tmp/Deadline-10.3.2.1-linux-installers.tar "$1"
chmod +x /tmp/Deadline-10.3.2.1-linux-installers.tar
mkdir -p $installers
tar -xvf /tmp/Deadline-10.3.2.1-linux-installers.tar -C $installers
ls -la $installers

chmod +x $installers/DeadlineRepository-10.3.2.1-linux-x64-installer.run
$installers/DeadlineRepository-10.3.2.1-linux-x64-installer.run\
      --debuglevel 4 \
      --mode unattended \
      --requireSSL false
      --prefix /apps/deadline10/repository \
      --dbname deadline10db \
      --dbhost deadline-mongo \
      --dbport 27017


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# cp -v "$SCRIPT_DIR/deadline.ini" /apps/deadline10/repository