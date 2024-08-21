echo "Installing $1 to $2"
wget -q -O /tmp/storyboard.appimage "$1"
chmod +x /tmp/storyboard.appimage
/tmp/storyboard.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/storyboard.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/storyboard.sh"
chmod +x "$2/storyboard.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/storyboard.png" "$2/storyboard.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="storyboard" --version="1.0" --latest_path="$2"/storyboard.sh --categories="storyboard, writing, screenplays" --destination="$2" --icon="$2"/storyboard.png
echo "Desktop file created."

cat $2/*.desktop