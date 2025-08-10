#!/bin/bash
set -e

echo "Installing Miecraft Launcher from $1 into $2"

# install wget
apt update
apt install -y wget

echo "Downloading Minecraft Launcher..."
wget -O "/tmp/Minecraft.tar.gz" $1

echo "Extracting the Minecraft Launcher..."
tar -xzf "/tmp/Minecraft.tar.gz" -C "/tmp"

cd "$2"
ls -la

# Move 'minecraft-launcher' directory to destination directory
mv -v "/tmp/minecraft-launcher" "$2/"

cd "$2"
ls -la
cd "$2/minecraft-launcher"
pwd
ls -la

echo "#!/bin/bash" > launcher.sh
echo "exec \"$2/minecraft-launcher/minecraft-launcher\"" >> launcher.sh

chmod +x "launcher.sh"


# app icon setup
echo "Copying desktop files..."
cd /terra/scripts
ls -la
cp "./assets/minecraft.png" "$2/minecraft.png"
cp "./assets/minecraft.desktop" "$2/minecraft.desktop"

# replace our icon/exec placeholder strings with proper values
cd $2
pwd
ls -la
sed -i -e "s@DESTINATION-PATH@$2/minecraft-launcher/launcher.sh@g" "$2/minecraft.desktop"
sed -i -e "s@ICON-PATH@$2/minecraft-launcher/minecraft.png@g" "$2/minecraft.desktop"
echo "Adding desktop file"
chmod -R 777 "$2/"
echo "Desktop file created."
cat $2/*.desktop



