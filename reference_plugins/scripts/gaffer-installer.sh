echo "Install Gaffer $1 to $2"
wget -q -O /tmp/gaffer.tar.gz "$1"
echo "Gaffer downloaded. Unpacking..."
chmod +x /tmp/gaffer.tar.gz
tar -xzf /tmp/gaffer.tar.gz -C $2
echo "Gaffer unpacked."

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/gaffer.sh" "$2/"
chmod +x "$2/gaffer.sh"


# app icon setup
cd $SCRIPT_DIR
cp "../assets/gaffer.png" "$2/gaffer.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Gaffer" --version="-1.4.11" --latest_path="$2"/gaffer.sh --categories="gaffer, graphics, vfx,3d" --destination="$2" --icon="$2"/gaffer.png
echo "Desktop file created."

chmod -R 777 "$2/"
cat $2/*.desktop
