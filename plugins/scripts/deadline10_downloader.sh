echo "Installing $1"

echo "Downloading Deadline"
installers=/apps/tmp/deadline10_installers
mkdir -p $installers

if [ "$DEV_APPS_DEBUG" = true ]
then
  echo "Dev Apps Debug is enabled - deadline copied with docker"
else
  # download the installer
  wget -q -O /tmp/Deadline-10.3.2.1-linux-installers.tar "$1"
fi
echo "Downloaded Deadline."
# permissions
chmod +x /tmp/Deadline-10.3.2.1-linux-installers.tar
# extract the installer
tar -xvf /tmp/Deadline-10.3.2.1-linux-installers.tar -C $installers
echo "Deadline install files extracted to $installers"


