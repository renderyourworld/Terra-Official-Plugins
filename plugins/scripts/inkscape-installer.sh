wget -q -O /tmp/inkscape.appimage "$1"
chmod +x /tmp/inkscape.appimage
/tmp/inkscape.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/inkscape.sh" "$2/"
chmod +x "$2/inkscape.sh"

