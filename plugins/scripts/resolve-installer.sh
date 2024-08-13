echo "Installing Davinci Resolve to $2"
wget -q -O /tmp/resolve.zip "$1"
chmod +x /tmp/resolve.zip
unzip resolve.zip -d "$2"
