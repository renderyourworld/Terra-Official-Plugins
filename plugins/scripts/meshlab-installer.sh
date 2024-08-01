wget -q -O /tmp/meshlab.appimage "$1"
chmod +x /tmp/meshlab.appimage
/tmp/meshlab.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

