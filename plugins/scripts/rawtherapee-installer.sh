echo  "Installing $1 to $2"
cd /tmp
wget -q -O /tmp/rawtherapee.appimage "$1"
chmod +x /tmp/rawtherapee.appimage
/tmp/rawtherapee.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/rawtherapee.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/rawtherapee.sh"
chmod +x "$2/rawtherapee.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/rawtherapee.png" "$2/rawtherapee.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Rawtherapee" --version="1.0" --latest_path="$2"/rawtherapee.sh --categories="rawtherapee, images" --destination="$2" --icon="$2"/rawtherapee.png
echo "Desktop file created."

cat $2/*.desktop