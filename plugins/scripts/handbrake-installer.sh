echo "Installing handbrake..."
wget -q -O /tmp/handbrake.appimage "$1"
chmod +x /tmp/handbrake.appimage

echo "Extracting handbrake..."
/tmp/handbrake.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/handbrake.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/handbrake.sh"
chmod +x "$2/handbrake.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/handbrake.png" "$2/handbrake.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="handbrake" --version="0.6" --latest_path="$2"/handbrake.sh --categories="handbrake, graphics, 2d" --destination="$2" --icon="$2"/handbrake.png
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
