wget -q -O /tmp/rawtherapee.appimage "$1"
chmod +x /tmp/rawtherapee.appimage
/tmp/rawtherapee.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

