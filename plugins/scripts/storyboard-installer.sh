wget -q -O /tmp/storyboard.appimage "$1"
chmod +x /tmp/storyboard.appimage
/tmp/storyboard.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/storyboard.sh" "$2/"
chmod +x "$2/storyboard.sh"

