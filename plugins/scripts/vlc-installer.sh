echo "Installing $1 to $2"
wget -q -O /tmp/vlc.appimage "$1"
chmod +x /tmp/vlc.appimage
/tmp/vlc.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/vlc.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/vlc.sh"
chmod +x "$2/vlc.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/vlc.png" "$2/vlc.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="VLC" --version="3.0" --latest_path="$2"/vlc.sh --categories="vlc, processes" --destination="$2" --icon="$2"/vlc.png
echo "Desktop file created."

cat $2/*.desktop