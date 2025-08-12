#!/bin/bash
set -e

# Update packages and install wget
apt update
apt install -y wget unzip

# Set local variables
LAUNCH="$DESTINATION/embergen2"
ICON="$DESTINATION/embergen.png"

# Download and Install the application
echo "Installing Embergen Version $VERSION into $DESTINATION"
echo "Downloading Embergen..."
wget -O "/tmp/embergen-$VERSION-linux.zip" "https://jangafx-software-files.s3.amazonaws.com/embergen/installers/linux/embergen-$VERSION-linux.zip"

echo "Extracting Embergen..."
unzip -o "/tmp/embergen-$VERSION-linux.zip" -d "$DESTINATION"

# Move contents of extracted directory to destination
find "$DESTINATION/EmberGen-$VERSION" -maxdepth 1 -mindepth 1 -exec mv -t "$DESTINATION" {} +

# Remove the now empty directory
rm -rf "$DESTINATION/EmberGen-$VERSION"

chmod -R 555 "$DESTINATION"

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