echo "Installing imagemagick..."
wget -q -O /tmp/imagemagick.appimage "$1"
chmod +x /tmp/imagemagick.appimage

echo "Extracting imagemagick..."
/tmp/imagemagick.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/imagemagick.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/imagemagick.sh"
chmod +x "$2/imagemagick.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/imagemagick.png" "$2/imagemagick.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Imagemagick" --version="7.1.1" --latest_path="$2"/imagemagick.sh --categories="imagemagick, graphics" --destination="$2" --icon="$2"/imagemagick.png
echo "Desktop file created."

cat $2/*.desktop
