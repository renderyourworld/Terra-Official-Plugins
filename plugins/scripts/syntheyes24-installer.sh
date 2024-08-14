echo "Downloading SynthEyes 24 installer from $1"
wget -q -O /apps/syntheys24.tar.gz "$1"
chmod +x /apps/syntheys241.tar.gz
mkdir -p /apps/installer
mkdir -p /apps/installer/synth
echo "Unpacking SynthEyes 24 installer"
tar -xvf /apps/syntheys241.tar.gz -C /apps/installer/synth
#ls -l /apps/installer
echo "Installing SynthEyes 24 to $2"
appdir="$2"

mkdir -p $appdir
/apps/installer/synth/SynthEyes/install.sh
echo "Install ok!"
# move
mv /opt/BorisFX/SynthEyes2024 $appdir