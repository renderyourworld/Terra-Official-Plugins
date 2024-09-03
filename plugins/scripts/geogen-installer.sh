echo "Installing geogen..."

wget -q -O /tmp/geogen.zip "$1"
chmod +x /tmp/geogen.zip

mkdir -p /tmp/app_install
unzip /tmp/geogen.zip -d $2
#/tmp/app_install > /dev/null

chmod -R 777 "$2/"
#
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/geogen.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/geogen.sh"
chmod +x "$2/geogen.sh"
chmod -R 777 "$2/"
#
## app icon setup
cd $SCRIPT_DIR
cp "../assets/geogen.png" "$2/geogen.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="GeoGen" --version="0.3" --latest_path="$2"/geogen.sh --categories="geogen, 3d" --destination="$2" --icon="$2"/geogen.png --terminal="False"
#
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
