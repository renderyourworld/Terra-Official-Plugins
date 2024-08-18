echo "Installing $1"
echo $2
installers=/tmp/deadline10_installers
wget -q -O /tmp/Deadline-10.3.2.1-linux-installers.tar "$1"
chmod +x /tmp/Deadline-10.3.2.1-linux-installers.tar
mkdir -p $installers
tar -xvf /tmp/Deadline-10.3.2.1-linux-installers.tar -C $installers

ls -la $installers

mkdir -p /apps/deadline10
mkdir -p /apps/deadline10/repository
mkdir -p /apps/deadline10/service

chmod +x $installers/DeadlineRepository-10.3.2.1-linux-x64-installer.run
$installers/DeadlineRepository-10.3.2.1-linux-x64-installer.run \
      --debuglevel 4 \
      --installmongodb false \
      --mode unattended \
      --requireSSL false \
      --dbssl false \
      --prefix /apps/deadline10/repository \
      --dbname deadline10db \
      --dbhost deadline-mongo \
      --dbport 27017
      #--setpermissions true


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR"/deadline.ini /apps/deadline10/service/deadline10.ini
cp -v "$SCRIPT_DIR"/deadline-repository-connection.ini /apps/deadline10/repository/settings/connection.ini
# ls /apps/deadline10/repository
