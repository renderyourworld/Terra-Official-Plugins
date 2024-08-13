wget -q -O /tmp/wpsoffice.appimage "$1"
chmod +x /tmp/wpsoffice.appimage
/tmp/wpsoffice.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

