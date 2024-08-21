wget -q -O /tmp/meshlab.appimage "$1"
chmod +x /tmp/meshlab.appimage
/tmp/meshlab.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/meshlab.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/meshlab.sh"
chmod +x "$2/meshlab.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/meshlab.png" "$2/meshlab.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Meshlab" --version="2022" --latest_path="$2"/meshlab.sh --categories="meshlab, 3d" --destination="$2" --icon="$2"/meshlab.png
echo "Desktop file created."

cat $2/*.desktop
