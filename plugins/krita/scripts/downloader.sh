#!/bin/bash
set -e

# Update packages and install wget
apt update
apt install -y wget

# Set local variables
LAUNCH="$DESTINATION/squashfs-root/AppRun"
ICON="$DESTINATION/krita.png"
DESKTOP_FILE="$DESTINATION/krita.desktop"

# Download and Install the application
echo "Installing Krita into $DESTINATION"
echo "Downloading Krita..."
wget -O "/tmp/krita.AppImage" $URL
chmod +x /tmp/krita.AppImage

echo "Extracting Krita..."
mkdir -p ${DESTINATION}
cd "$DESTINATION/"
/tmp/krita.AppImage --appimage-extract > /dev/null
chmod -R 777 "$DESTINATION/"

# App icon setup
echo "Adding desktop files"
cp -v "/terra/scripts/assets/krita.png" "$DESTINATION/"
rm -rfv "$DESKTOP_FILE"

echo "[Desktop Entry]
Version=5.2.9
Name=Krita 5.2.9
Comment=Krita is a professional FREE and open source painting program.
Exec=$LAUNCH
Icon=$ICON
Terminal=true
Type=Application
Categories=X-Polaris
StartupWMClass=krita" >> "$DESKTOP_FILE"

echo "Desktop file created at $DESKTOP_FILE"
cat "$DESKTOP_FILE"



