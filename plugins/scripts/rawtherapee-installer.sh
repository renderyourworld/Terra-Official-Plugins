wget -q -O /tmp/rawtherapee.appimage "$1"
chmod +x /tmp/rawtherapee.appimage
/tmp/rawtherapee.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/rawtherapee.sh" "$2/"
chmod +x "$2/rawtherapee.sh"

# app icon setup
cp "../assets/rawtherapee.png" "$2/rawtherapee.png"

# desktop file setup
echo "
[Desktop Entry]
Name=PureRef
Exec=/bin/bash -x $2/rawtherapee.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/rawtherapee.png" > "$2/rawtherapee.desktop"
