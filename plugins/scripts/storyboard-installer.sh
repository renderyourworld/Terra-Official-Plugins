wget -q -O /tmp/storyboard.appimage "$1"
chmod +x /tmp/storyboard.appimage
/tmp/storyboard.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/storyboard.sh" "$2/"
chmod +x "$2/storyboard.sh"

# app icon setup
cp "../assets/storyboard.png" "$2/storyboard.png"

# desktop file setup
echo "
[Desktop Entry]
Name=PureRef
Exec=/bin/bash -x $2/storyboard.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/storyboard.png" > "$2/storyboard.desktop"