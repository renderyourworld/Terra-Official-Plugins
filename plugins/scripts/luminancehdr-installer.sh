wget -q -O /tmp/luminancehdr.appimage "$1"
chmod +x /tmp/luminancehdr.appimage
/tmp/luminancehdr.appimage --appimage-extract > /dev/null
mkdir -p "$2/"
ls -la "$2/"
mv ./squashfs-root "$2/"
ls "$2/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/luminancehdr.sh" "$2/"
chmod +x "$2/luminancehdr.sh"
