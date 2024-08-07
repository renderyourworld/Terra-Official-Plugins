wget -q -O /tmp/meshlab.appimage "$1"
chmod +x /tmp/meshlab.appimage
/tmp/meshlab.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/meshlab.sh" "$2/"
chmod +x "$2/meshlab.sh"

# app icon setup
cp "../assets/meshlab.png" "$2/meshlab.png"

# desktop file setup
echo "
[Desktop Entry]
Name=Meshlab
Exec=/bin/bash -x $2/meshlab.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/meshlab.png" > "$2/meshlab.desktop"

