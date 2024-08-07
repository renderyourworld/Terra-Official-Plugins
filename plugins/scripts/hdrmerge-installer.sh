wget -q -O /tmp/hdrmerge.appimage "$1"
chmod +x /tmp/hdrmerge.appimage
/tmp/hdrmerge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/hdrmerge.sh" "$2/"
chmod +x "$2/hdrmerge.sh"