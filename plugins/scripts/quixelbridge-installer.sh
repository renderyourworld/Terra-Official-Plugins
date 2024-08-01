wget -q -O /tmp/quixelbridge.appimage "$1"
chmod +x /tmp/quixelbridge.appimage
/tmp/quixelbridge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
chmod -R 777 $2

