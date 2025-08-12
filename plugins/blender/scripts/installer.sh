#!/bin/bash
set -e

# Update packages and install wget
apt update
apt install -y wget xz-utils

# Set local variables
INSTALL_DIR="$DESTINATION/blender-$VERSION-linux-x64"
LAUNCH="$INSTALL_DIR/blender %f"
ICON="$INSTALL_DIR/blender.png"
RELEASE=$(echo $VERSION | cut -d'.' -f1-2) # split 4.5.1 to 4.5

# Download and Install the application
echo "Installing Blender Version $VERSION into $INSTALL_DIR"
echo "Downloading Blender..."
wget -O "/tmp/blender-$VERSION-linux-x64.tar.xz" "https://download.blender.org/release/Blender$RELEASE/blender-$VERSION-linux-x64.tar.xz"

echo "Extracting Blender..."
tar -xJvf "/tmp/blender-$VERSION-linux-x64.tar.xz" -C "$DESTINATION/"
chmod -R 555 "$DESTINATION"

# App icon setup
echo "Adding desktop files"
cp -v "${PWD}/assets/blender.png" "$INSTALL_DIR/"
rm -rfv "$INSTALL_DIR/blender.desktop"

echo "[Desktop Entry]
Version=$VERSION
Name=Blender $VERSION
Comment=3D modeling, animation, rendering and post-production
Exec=$LAUNCH
Icon=$ICON
Terminal=true
Type=Application
Categories=X-Polaris
MimeType=application/x-blender
StartupWMClass=Blender" >> "$INSTALL_DIR"/blender.desktop

echo "Desktop file created at $INSTALL_DIR/blender.desktop"
cat "$INSTALL_DIR"/*.desktop