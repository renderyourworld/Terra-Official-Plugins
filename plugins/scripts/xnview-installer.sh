echo "Installing $1 to $2"
cd /tmp
wget -q -O /tmp/xnview.appimage "$1"
chmod +x /tmp/xnview.appimage
/tmp/xnview.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/xnview.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/xnview.sh"
chmod +x "$2/xnview.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/xnview.png" "$2/xnview.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Xnview" --version="2022" --latest_path="$2"/xnview.sh --categories="xnview, viewer" --destination="$2" --icon="$2"/xnview.png
echo "Desktop file created."

cat $2/*.desktop
