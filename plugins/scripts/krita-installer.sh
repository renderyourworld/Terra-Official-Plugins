wget -q -O /tmp/krita.appimage "$1"
chmod +x /tmp/krita.appimage
/tmp/kdenlive.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

