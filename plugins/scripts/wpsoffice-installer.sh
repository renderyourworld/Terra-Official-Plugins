wget -q -O /tmp/wpsoffice.deb "$1"
chmod +x /tmp/wpsoffice.deb
dpkg-deb -x /tmp/wpsoffice.deb --instdir=$2