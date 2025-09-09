#!/bin/bash
set -e

# Update packages and install wget
apt update
apt install -y wget xz-utils libxcb-xinerama0 libxcb-icccm4 libxcb-image0 libxcb-shm0 libxcb-keysyms1 libxcb-render-util0 libxcb-sync1 libxcb-xfixes0 libxcb-cursor0 rpm2cpio cpio

# Set local variables
INSTALL_DIR="$DESTINATION/flow-production-tracking"
LAUNCH="$INSTALL_DIR/Shotgun"
ICON="$INSTALL_DIR/flow.png"
DESKTOP_FILE="$INSTALL_DIR/flow-production-tracking.desktop"
RPM_FILE="flow_production_tracking-current-1.x86_64.rpm"

# Download and Install the application
echo "Installing Autodesk Flow Production Tracking into $INSTALL_DIR"
echo "Downloading Autodesk Flow Production Tracking..."
wget -O "/tmp/$RPM_FILE" "$URL"

# Extract the RPM package
echo "Extracting Flow Production Tracking..."
mkdir -p "$INSTALL_DIR"
cd /tmp
rpm2cpio "$RPM_FILE" | cpio -idmv

# Move the extracted files to the installation directory
mv /tmp/opt/Shotgun/* "$INSTALL_DIR/"

chmod -R 555 "$INSTALL_DIR"

# App icon setup
echo "Adding desktop files"
cp -v "/terra/scripts/assets/flow.png" "$INSTALL_DIR/"
rm -rfv "$DESKTOP_FILE"

echo "[Desktop Entry]
Name=Autodesk Flow Production Tracking
Comment=Autodesk Flow Production Tracking
Exec=$LAUNCH
Icon=$ICON
Terminal=true
Type=Application
Categories=X-Polaris" >> "$DESKTOP_FILE"

echo "Desktop file created at $DESKTOP_FILE"
cat "$DESKTOP_FILE"

echo "Testing"