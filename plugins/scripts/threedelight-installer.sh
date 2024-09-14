wget -q -O /tmp/threedlight.tar.xz "$1"
chmod +x /tmp/threedlight.tar.xz

tar -xvf /tmp/threedlight.tar.xz -C /tmp/unpack_threedlight
mv /tmp/unpack_threedlight "$2"
ls "$2"

chmod -R 777 "$2/"
# install the software