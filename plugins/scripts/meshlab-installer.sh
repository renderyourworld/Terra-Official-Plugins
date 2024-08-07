wget -q -O /tmp/meshlab.appimage "$1"
chmod +x /tmp/meshlab.appimage
/tmp/meshlab.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/meshlab.sh" "$2/"
chmod +x "$2/meshlab.sh"

