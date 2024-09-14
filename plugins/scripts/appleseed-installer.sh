echo "Installing appleseed $1 - $2 ..."


echo "Downloading appleseed..."
wget -q -O /tmp/appleseed.zip $1

echo "Extracting appleseed..."
unzip /tmp/appleseed.zip -d "$2/"

ls $2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/appleseed.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/appleseed.sh"
chmod +x "$2/appleseed.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/appleseed.png" "$2/appleseed.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Appleseed" --version="2.1" --latest_path="$2"/appleseed.sh --categories="appleseed, render" --destination="$2" --icon="$2"/appleseed.png
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
