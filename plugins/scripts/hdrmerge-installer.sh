echo "Installing hdrmerge..."
wget -q -O /tmp/hdrmerge.appimage "$1"
chmod +x /tmp/hdrmerge.appimage

echo "Extracting hdrmerge..."
/tmp/hdrmerge.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/hdrmerge.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/hdrmerge.sh"
chmod +x "$2/hdrmerge.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/hdrmerge.png" "$2/hdrmerge.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Hdrmerge" --version="0.6" --latest_path="$2"/hdrmerge.sh --categories="hdrmerge, graphics, 2d" --destination="$2" --icon="$2"/hdrmerge.png
echo "Desktop file created."

cat $2/*.desktop
