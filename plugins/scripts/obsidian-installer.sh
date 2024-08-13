wget -q -O /tmp/obsidian.appimage "$1"
chmod +x /tmp/obsidian.appimage
/tmp/obsidian.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/obsidian.sh" "$2/"
chmod +x "$2/obsidian.sh"

# app icon setup
cp "../assets/obsidian.png" "$2/obsidian.png"

# desktop file setup
echo "
[Desktop Entry]
Name=XnView
Exec=/bin/bash -x $2/obsidian.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/obsidian.png" > "$2/obsidian.desktop"
