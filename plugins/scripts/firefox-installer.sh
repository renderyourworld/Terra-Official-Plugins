echo "Installing firefox..."
wget -q -O /tmp/firefox.appimage "$1"
chmod +x /tmp/firefox.appimage

echo "Extracting firefox..."
/tmp/firefox.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/firefox.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/firefox.sh"
chmod +x "$2/firefox.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/firefox.png" "$2/firefox.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Firefox" --version="30.0" --latest_path="$2"/firefox.sh --categories="firefox, web" --destination="$2" --icon="$2"/firefox.png --terminal="False"
echo "Desktop file created."

cat $2/*.desktop
