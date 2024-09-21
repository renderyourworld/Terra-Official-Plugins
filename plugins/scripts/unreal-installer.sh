 template for appimage
echo "Installing unreal..."
wget -q -O /tmp/unreal.zip "$1"
chmod +x /tmp/unreal.zip

mkdir -p $2
echo "Extracting unreal..."
unzip /tmp/unreal.zip -C $2/

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/unreal.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/unreal.sh"
chmod +x "$2/unreal.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/unreal.png" "$2/unreal.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="unreal" --version="5.4.4" --latest_path="$2"/unreal.sh --categories="unreal" --destination="$2" --icon="$2"/unreal.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
