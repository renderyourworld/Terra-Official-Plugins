wget -q -O /tmp/cpux.appimage "$1"
chmod +x /tmp/cpux.appimage
/tmp/cpux.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/cpux.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/cpux.sh"
chmod +x "$2/cpux.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/cpux.png" "$2/cpux.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="CpuX" --version="1.0" --latest_path="$2"/cpux.sh --categories="cpux, cpu, system" --destination="$2" --icon="$2"/cpux.png
echo "Desktop file created."

cat $2/*.desktop