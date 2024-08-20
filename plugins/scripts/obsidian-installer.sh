echo "Installing $1 to $2"

echo "Downloading Obsidian from $1"
wget -q -O /tmp/obsidian.appimage "$1"
chmod +x /tmp/obsidian.appimage

echo "Unpacking Obsidian"
/tmp/obsidian.appimage --appimage-extract > /dev/null
mkdir -p "$2"
mv ./squashfs-root "$2/"

echo "Setting up Obsidian"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/obsidian.sh" "$2"/obsidian.sh
chmod +x "$2/obsidian.sh"

# app icon setup
cd $SCRIPT_DIR
cp ../assets/obsidian.png "$2"/obsidian.png

# desktop file setup
echo "
[Desktop Entry]
Name=XnView
Exec=/bin/bash -x $2/obsidian.sh
Terminal=true
Type=Application
Categories=Apps
Icon=$2/obsidian.png" > "$2/obsidian.desktop"
