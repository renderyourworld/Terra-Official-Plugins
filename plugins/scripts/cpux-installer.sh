wget -q -O /tmp/cpux.appimage "$1"
chmod +x /tmp/cpux.appimage
/tmp/cpux.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/cpux.sh" "$2/"
chmod +x "$2/cpux.sh"

# app icon setup
cp "../assets/cpux.png" "$2/cpux.png"

# desktop file setup
echo "
[Desktop Entry]
Name=cpux
Exec=/bin/bash -x $2/cpux.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/cpux.png" > "$2/cpux.desktop"
