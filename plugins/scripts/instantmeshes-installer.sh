wget -q -O /tmp/instantmeshes.zip "$1"
chmod +x /tmp/instantmeshes.zip
unzip /tmp/instantmeshes.zip -d "$2"
wget -q -O /tmp/dataset.zip https://instant-meshes.s3.eu-central-1.amazonaws.com/instant-meshes-datasets.zip > /dev/null
chmod +x /tmp/dataset.zip
unzip /tmp/dataset.zip -d "$2" > /dev/null
chmod -R 777 "$2"