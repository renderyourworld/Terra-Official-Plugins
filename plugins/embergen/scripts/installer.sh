#!/bin/bash
set -e

# Update packages and install wget
apt update
apt install -y wget unzip

# Set local variables
INSTALL_DIR="$DESTINATION/embergen-$VERSION-linux"
LAUNCH="$INSTALL_DIR/embergen"
ICON="$DESTINATION/embergen.png"

# Download and Install the application
echo "Installing Embergen Version $VERSION into $INSTALL_DIR"
echo "Downloading Embergen..."
wget -O "/tmp/embergen-$VERSION-linux.zip" "https://jangafx-software-files.s3.amazonaws.com/embergen/installers/linux/embergen-$VERSION-linux.zip"

echo "Extracting Embergen..."
unzip "/tmp/embergen-$VERSION-linux.zip" -d "$DESTINATION/"
mv "$DESTINATION/embergen-$VERSION-linux" "$INSTALL_DIR"
chmod -R 555 "$INSTALL_DIR"

# App icon setup
echo "Adding desktop files"
cp -v "${PWD}/assets/embergen.png" "$DESTINATION/"
rm -rfv "$DESTINATION/embergen.desktop"

echo "[Desktop Entry]
Version=$VERSION
Name=Embergen $VERSION
Comment=Real-time volumetric effects
Exec=$LAUNCH
Icon=$ICON
Terminal=true
Type=Application
Categories=X-Polaris
MimeType=application/x-embergen
StartupWMClass=Embergen" >> "$DESTINATION"/embergen.desktop

echo "Desktop file created at $DESTINATION/embergen.desktop"
cat "$DESTINATION"/*.desktop