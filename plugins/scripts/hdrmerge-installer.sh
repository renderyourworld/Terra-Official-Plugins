wget -q -O /tmp/hdrmerge.appimage "$1"
chmod +x /tmp/hdrmerge.appimage
/tmp/hdrmerge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

