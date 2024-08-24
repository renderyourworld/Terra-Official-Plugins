wget -q -O /tmp/audacity.appimage "$1"
chmod +x /tmp/audacity.appimage
/tmp/audacity.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/audacity.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/audacity.sh"
chmod +x "$2/audacity.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/audacity.png" "$2/audacity.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Audacity" --version="7.8" --latest_path="$2"/audacity.sh --categories="audio, audacity" --destination="$2" --icon="$2"/audacity.png
echo "Desktop file created."

cat $2/*.desktop