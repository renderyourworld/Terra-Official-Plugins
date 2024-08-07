wget -q -O /tmp/xnview.appimage "$1"
chmod +x /tmp/xnview.appimage
/tmp/xnview.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/xnview.sh" "$2/"
chmod +x "$2/xnview.sh"

