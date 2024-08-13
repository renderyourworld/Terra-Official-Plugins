echo "Install Gaffer"
wget -q -O /tmp/gaffer.tar.gz "$1"
echo "Gaffer downloaded. Unpacking..."
chmod +x /tmp/gaffer.tar.gz
tar -xzf /tmp/gaffer.tar.gz -C $2
echo "Gaffer unpacked."
