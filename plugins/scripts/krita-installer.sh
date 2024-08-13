wget -q -O /tmp/krita.appimage "$1"
chmod +x /tmp/krita.appimage
/tmp/krita.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/krita.sh" "$2/"
chmod +x "$2/krita.sh"

# app icon setup
cp "../assets/krita.png" "$2/krita.png"

# desktop file setup
echo "
[Desktop Entry]
Name=Krita
Exec=/bin/bash -x $2/krita.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/krita.png" > "$2/krita.desktop"