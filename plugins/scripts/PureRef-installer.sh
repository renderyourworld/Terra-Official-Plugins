echo "Installing PureRef  $1 $2"

chmod +x /tmp/pureref2.Appimage
/tmp/pureref2.Appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/pureref.sh" "$2/"
chmod +x "$2/pureref.sh"

# app icon setup
cp "../assets/pureref.png" "$2/pureref.png"

# desktop file setup
echo "
[Desktop Entry]
Name=PureRef
Exec=/bin/bash -x $2/pureref.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/pureref.png" > "$2/pureref.desktop"

