wget -q -O /tmp/syntheys24.tar.gz "$1"
chmod +x /tmp/syntheys24.tar.gz

tar -xvf /tmp/syntheys24.tar.gz -C "$2"
ls -l "$2"