wget -q -O /tmp/hdrmerge.appimage "$1"
chmod +x /tmp/hdrmerge.appimage
/tmp/hdrmerge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/hdrmerge.sh" "$2/"
chmod +x "$2/hdrmerge.sh"

# app icon setup
cp "../assets/hdrmerge.png" "$2/hdrmerge.png"

# desktop file setup
echo "
[Desktop Entry]
Name=HdrMerge
Exec=/bin/bash -x $2/hdrmerge.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/hdrmerge.png" > "$2/hdrmerge.desktop"