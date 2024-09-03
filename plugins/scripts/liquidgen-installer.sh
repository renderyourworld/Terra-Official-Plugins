echo "Installing liquidgen..."

wget -q -O /tmp/liquidgen.zip "$1"
chmod +x /tmp/liquidgen.zip

mkdir -p /tmp/app_install
unzip /tmp/liquidgen.zip -d $2

chmod -R 777 "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/liquidgen.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/liquidgen.sh"
chmod +x "$2/liquidgen.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/liquidgen.png" "$2/liquidgen.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="LiquidGen" --version="0.3" --latest_path="$2"/liquidgen.sh --categories="liquidgen, 3d" --destination="$2" --icon="$2"/liquidgen.png --terminal="False"

echo "Desktop file created."
chmod -R 777 "$2/"
#cat $2/*.desktop
