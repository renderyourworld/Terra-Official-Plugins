echo "Installing PureRef  $1 $2"

chmod +x /tmp/pureref2.Appimage
/tmp/pureref2.Appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
