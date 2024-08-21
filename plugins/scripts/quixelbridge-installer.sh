echo "Installing $1 to $2"
wget -q -O /tmp/quixelbridge.appimage "$1"
chmod +x /tmp/quixelbridge.appimage
/tmp/quixelbridge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
chmod -R 777 $2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/quixel_bridge.sh" "$2/"
chmod +x "$2/quixel_bridge.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp ../assets/quixel_bridge.png "$2"/quixel_bridge.png
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Bridge" --version="1.0.7" --latest_path="$2"/quixel_bridge.sh --categories="quixel, bridge, texturing" --destination="$2" --icon="$2"/quixel_bridge.png
echo "Desktop file created."

cat $2/*.desktop

