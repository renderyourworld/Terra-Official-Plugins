echo "Installing inkscape..."
cd /tmp
wget -q -O /tmp/inkscape.appimage "$1"
chmod +x /tmp/inkscape.appimage

echo "Extracting inkscape..."
/tmp/inkscape.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/inkscape.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/inkscape.sh"
chmod +x "$2/inkscape.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/inkscape.png" "$2/inkscape.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="inkscape" --version="1.0" --latest_path="$2"/inkscape.sh --categories="inkscape, graphics, 2d" --destination="$2" --icon="$2"/inkscape.png
echo "Desktop file created."

cat $2/*.desktop


