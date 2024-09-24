wget -q -O /tmp/silhouette2024.tar.gz "$1"
chmod +x /tmp/silhouette2024.tar.gz

tar -xvf /tmp/silhouette2024.tar.gz -C "$2"
ls -l "$2"

chmod -R 777 "$2/"