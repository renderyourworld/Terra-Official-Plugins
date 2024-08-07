wget -q -O /tmp/quixelbridge.appimage "$1"
chmod +x /tmp/quixelbridge.appimage
/tmp/quixelbridge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
chmod -R 777 $2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/quixel_bridge.sh" "$2/"
chmod +x "$2/quixel_bridge.sh"