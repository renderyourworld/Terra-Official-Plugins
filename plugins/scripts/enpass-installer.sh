wget -q -O /tmp/enpass.appimage "$1"
chmod +x /tmp/enpass.appimage
/tmp/enpass.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/enpass.sh" "$2/"
chmod +x "$2/enpass.sh"

# app icon setup
cp "../assets/enpass.png" "$2/enpass.png"

# desktop file setup
echo "
[Desktop Entry]
Name=enpass
Exec=/bin/bash -x $2/enpass.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/enpass.png" > "$2/enpass.desktop"
