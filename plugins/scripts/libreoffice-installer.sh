echo "Installing libreoffice..."
cd /tmp

wget -q -O /tmp/libreoffice.appimage "$1"
chmod +x /tmp/libreoffice.appimage
/tmp/libreoffice.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
chmod -R 777 "$2/"
