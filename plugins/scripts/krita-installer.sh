wget -q -O /tmp/krita.appimage "$1"
chmod +x /tmp/krita.appimage
/tmp/krita.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/krita.sh" "$2/"
chmod +x "$2/krita.sh"

