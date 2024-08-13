wget -q -O /tmp/tlm.appimage "$1"
chmod +x /tmp/tlm.appimage
/tmp/tlm.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/tlm.sh" "$2/"
chmod +x "$2/tlm.sh"

# app icon setup
cp "../assets/tlm.png" "$2/tlm.png"

# desktop file setup
echo "
[Desktop Entry]
Name=Tlm
Exec=/bin/bash -x $2/tlm.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/tlm.png" > "$2/tlm.desktop"
