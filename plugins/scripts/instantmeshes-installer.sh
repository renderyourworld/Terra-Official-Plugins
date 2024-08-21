echo "Installing instantmeshes...$1 $2"
wget -q -O /tmp/instantmeshes.zip "$1"
chmod +x /tmp/instantmeshes.zip
unzip /tmp/instantmeshes.zip -d "$2"
wget -q -O /tmp/dataset.zip https://instant-meshes.s3.eu-central-1.amazonaws.com/instant-meshes-datasets.zip > /dev/null
chmod +x /tmp/dataset.zip
unzip /tmp/dataset.zip -d "$2" > /dev/null
chmod -R 777 "$2"
echo "Instant Meshes installed."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/instantmeshes.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/instantmeshes.sh"
chmod +x "$2/instantmeshes.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/instantmeshes.png" "$2/instantmeshes.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="instantmeshes" --version="1.0" --latest_path="$2"/instantmeshes.sh --categories="instantmeshes, 3d, vfx" --destination="$2" --icon="$2"/instantmeshes.png
echo "Desktop file created."

cat $2/*.desktop

