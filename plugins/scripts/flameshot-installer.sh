wget -q -O /tmp/flameshot.appimage "$1"
chmod +x /tmp/flameshot.appimage
/tmp/flameshot.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

