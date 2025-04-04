#!/bin/bash
set -e
# install wget
apt update
apt install -y wget
echo "Installing firefox..."
cd /tmp
echo "installing wget"
wget -q -O /tmp/firefox.appimage "$1"
chmod +x /tmp/firefox.appimage

echo "Extracting firefox..."
/tmp/firefox.appimage --appimage-extract > /dev/null
cp -r -v ./squashfs-root "$2/"
cd -
cp -v ./firefox.sh $2/
sed -i "s@ROOT_APP@$2@g" "$2/firefox.sh"
chmod +x "$2/firefox.sh"

# app icon setup
pwd
ls -la
cp "../assets/firefox.png" "$2/firefox.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Firefox" --version="30.0" --latest_path="$2"/firefox.sh --categories="firefox, web" --destination="$2" --icon="$2"/firefox.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
