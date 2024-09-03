echo "Installing embergen..."

wget -q -O /tmp/embergen.zip "$1"
chmod +x /tmp/embergen.zip

mkdir -p /tmp/app_install
unzip /tmp/embergen.zip -d /tmp/app_install > /dev/null
mv /tmp/app_install/EmberGen-1.2.1-linux/EmberGen-1.2.1 /apps/embergen/EmberGen-1.2.1
chmod -R 777 "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/embergen.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/embergen.sh"
chmod +x "$2/embergen.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/embergen.png" "$2/embergen.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Embergen" --version="1.2" --latest_path="$2"/embergen.sh --categories="embergen, 3d" --destination="$2" --icon="$2"/embergen.png --terminal="False"

echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
