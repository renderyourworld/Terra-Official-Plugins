echo "Installing PureRef  $1 $2"

chmod +x /tmp/pureref2.Appimage
/tmp/pureref2.Appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/pureref.sh" "$2/"
chmod +x "$2/pureref.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/pureref.png" "$2/pureref.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="pureref" --version="1.0" --latest_path="$2"/pureref.sh --categories="pureref, images,references" --destination="$2" --icon="$2"/pureref.png
echo "Desktop file created."

cat $2/*.desktop