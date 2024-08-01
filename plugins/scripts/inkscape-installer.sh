wget -q -O /tmp/inkscape.appimage "$1"
chmod +x /tmp/inkscape.appimage
/tmp/inkscape.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

