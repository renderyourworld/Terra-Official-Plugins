echo "Installing Meshroom $1 - $2"
wget -q -O /tmp/meshroom.tar.gz "$1"
chmod +x /tmp/meshroom.tar.gz
tar xf $1 -C $2