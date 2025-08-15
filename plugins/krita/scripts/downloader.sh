#!/bin/bash
set -e

# Update packages and install wget
apt update
apt install -y wget

# Set local variables
LAUNCH="$DESTINATION/krita %f"
ICON="$DESTINATION/krita.png"
DESKTOP_FILE="$DESTINATION/krita.desktop"

# Download and Install the application
echo "Installing Krita into $DESTINATION"
echo "Downloading Krita..."
wget -O "/tmp/krita.AppImage" $URL
chmod +x /tmp/krita.AppImage

echo "Extracting Krita..."
/tmp/krita.AppImage --appimage-extract > /dev/null
cp -r -v ./squashfs-root "$2/"
cd /terra/scripts

cp -v ./rustdesk.sh $2/
sed -i "s@ROOT_APP@$2@g" "$2/rustdesk.sh"
chmod +x "$2/rustdesk.sh"

# app icon setup
cp "./assets/rustdesk.png" "$2/rustdesk.png"
cp "./assets/rustdesk.desktop" "$2/rustdesk.desktop"

# replace our icon/exec placeholder strings with proper values
cd $2
pwd
ls -la
sed -i -e "s@DESTINATION-PATH@$2/rustdesk.sh@g" "$2/rustdesk.desktop"
sed -i -e "s@ICON-PATH@$2/rustdesk.png@g" "$2/rustdesk.desktop"
echo "Adding desktop file"
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop



