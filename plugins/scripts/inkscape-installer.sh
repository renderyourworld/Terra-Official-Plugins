wget -q -O /tmp/inkscape.appimage "$1"
chmod +x /tmp/inkscape.appimage
/tmp/inkscape.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/inkscape.sh" "$2/"
chmod +x "$2/inkscape.sh"

# app icon setup
cp "../assets/inkscape.png" "$2/inkscape.png"

# desktop file setup
echo "
[Desktop Entry]
Name=Inkscape
Exec=/bin/bash -x $2/inkscape.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/inkscape.png" > "$2/inkscape.desktop"

