wget -q -O /tmp/flameshot.appimage "$1"
chmod +x /tmp/flameshot.appimage
/tmp/flameshot.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/flameshot.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/flameshot.sh"
chmod +x "$2/flameshot.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/flameshot.png" "$2/flameshot.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Flameshot" --version="1.0" --latest_path="$2"/flameshot.sh --categories="flameshot, graphics, 2d" --destination="$2" --icon="$2"/flameshot.png
echo "Desktop file created."

cat $2/*.desktop
