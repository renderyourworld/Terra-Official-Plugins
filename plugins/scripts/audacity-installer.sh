wget -q -O /tmp/audacity.appimage "$1"
chmod +x /tmp/audacity.appimage
/tmp/audacity.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/audacity.sh" "$2/"
chmod +x "$2/audacity.sh"

# app icon setup
cp "../assets/audacity.png" "$2/audacity.png"

# desktop file setup
echo "
[Desktop Entry]
Name=audacity
Exec=/bin/bash -x $2/audacity.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/audacity.png" > "$2/audacity.desktop"
