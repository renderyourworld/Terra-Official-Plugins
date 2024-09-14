echo "Installing $1 to $2"
cd /tmp

echo "Downloading Obsidian from $1"
wget -q -O /tmp/obsidian.appimage "$1"
chmod +x /tmp/obsidian.appimage

echo "Unpacking Obsidian"
/tmp/obsidian.appimage --appimage-extract > /dev/null
mkdir -p "$2"

mv ./squashfs-root "$2/"
chmod -R 777 "$2/"

echo "Setting up Obsidian"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/obsidian.sh" "$2"/obsidian.sh
sed -i "s@ROOT_APP@$2@g" "$2/obsidian.sh"
chmod +x "$2/obsidian.sh"

# app icon setup
cd $SCRIPT_DIR
cp ../assets/obsidian.png "$2"/obsidian.png
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Obsidian" --version="1.6.7" --latest_path="$2"/obsidian.sh --categories="text, obsidian, markdown, notes, editor" --destination="$2" --icon="$2"/obsidian.png
echo "Desktop file created."

cat $2/*.desktop