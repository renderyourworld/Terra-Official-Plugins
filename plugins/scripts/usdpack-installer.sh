wget -q -O /tmp/usdpack.zip "$1"
wget -q -O /tmp/kitchen_scene.zip https://s3.eu-central-1.wasabisys.com/juno-deps/Kitchen_set.zip
chmod +x /tmp/usdpack.zip /tmp/kitchen_scene.zip
unzip /tmp/usdpack.zip -d $2
unzip /tmp/kitchen_scene.zip -d $2/demo_kitchen_scene