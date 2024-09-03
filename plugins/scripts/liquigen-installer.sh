echo "Installing liquigen..."

wget -q -O /tmp/liquigen.zip "$1"
chmod +x /tmp/liquigen.zip

mkdir -p /tmp/app_install
unzip /tmp/liquigen.zip -d $2

chmod -R 777 "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/liquigen.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/liquigen.sh"
chmod +x "$2/liquigen.sh"
chmod -R 777 "$2/"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/liquigen.png" "$2/liquigen.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="LiquiGen" --version="0.3" --latest_path="$2"/liquigen.sh --categories="liquigen, 3d" --destination="$2" --icon="$2"/liquigen.png --terminal="False"

echo "Desktop file created."
chmod -R 777 "$2/"
#cat $2/*.desktop
