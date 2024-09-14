echo "Installing krita..."
cd /tmp

wget -q -O /tmp/krita.appimage "$1"
chmod +x /tmp/krita.appimage
/tmp/krita.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/krita.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/krita.sh"
chmod +x "$2/krita.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/krita.png" "$2/krita.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="krita" --version="1.0" --latest_path="$2"/krita.sh --categories="X-Polaris;Graphics" --destination="$2" --icon="$2"/krita.png
echo "Desktop file created."

cat $2/*.desktop
