echo "Installing $1 to $2"
wget -q -O /tmp/tlm.appimage "$1"
chmod +x /tmp/tlm.appimage
/tmp/tlm.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/tlm.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/tlm.sh"
chmod +x "$2/tlm.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/tlm.png" "$2/tlm.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Tlm" --version="1.0" --latest_path="$2"/tlm.sh --categories="tlm, processes" --destination="$2" --icon="$2"/tlm.png
echo "Desktop file created."

cat $2/*.desktop