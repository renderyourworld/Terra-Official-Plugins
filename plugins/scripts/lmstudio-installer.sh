echo "Installing LM-Studio ..."
wget -q -O /tmp/lmstudio.appimage "$1"
chmod +x /tmp/lmstudio.appimage

echo "Extracting lmstudio..."
/tmp/lmstudio.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/lmstudio.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/lmstudio.sh"
chmod +x "$2/lmstudio.sh"
chmod -R 777 "$2/"
# app icon setup
cd $SCRIPT_DIR
cp "../assets/lmstudio.png" "$2/lmstudio.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="LMStudio" --version="0.39" --latest_path="$2"/lmstudio.sh --categories="lmstudio" --destination="$2" --icon="$2"/lmstudio.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
