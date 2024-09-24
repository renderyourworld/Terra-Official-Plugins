# template for appimage
echo "Installing steam..."

cd /tmp
wget -q -O /tmp/steam.appimage "$1"
chmod +x /tmp/steam.appimage

echo "Extracting steam..."
/tmp/steam.appimage --appimage-extract > /dev/null
mv /tmp/squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/steam.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/steam.sh"
chmod +x "$2/steam.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/steam.png" "$2/steam.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Steam Client" --version="1.0" --latest_path="$2"/steam.sh --categories="steam, web" --destination="$2" --icon="$2"/steam.png --terminal="False"
echo "Desktop file created."

chmod -R 777 "$2/"

cat $2/*.desktop
