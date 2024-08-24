installers=/apps/tmp/deadline10_installers
echo "Startying Deadline 10 repository installation > $2"

# create repository directories
mkdir -p $installers
mkdir -p $2
mkdir -p $2/repository
mkdir -p $2/service

# permissions
chmod +x $installers/DeadlineRepository-10.3.2.1-linux-x64-installer.run

echo "Installing Deadline 10 repository from $installers"

# install the repository
$installers/DeadlineRepository-10.3.2.1-linux-x64-installer.run \
      --debuglevel 4 \
      --installmongodb false \
      --mode unattended \
      --requireSSL false \
      --dbssl false \
      --prefix $2/repository \
      --dbname deadline10db \
      --dbhost deadline-mongo \
      --dbport 27017
      #--setpermissions true

echo "Deadline 10 repository installed. Setting up ini files."
# setup the repository
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR"/deadline.ini $2/service/deadline10.ini
cp -v "$SCRIPT_DIR"/deadline-repository-connection.ini $2/repository/settings/connection.ini
cp -v "$SCRIPT_DIR"/deadline_env.sh $2/service/deadline_env.sh
chmod +x $2/service/deadline_env.sh
echo "Deadline 10 repository setup done."


