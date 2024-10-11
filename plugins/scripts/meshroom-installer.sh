echo "Installing Meshroom $1 - $2"

cd /tmp
wget -q -O /tmp/meshroom.tar.gz "$1"
chmod +x /tmp/meshroom.tar.gz
tar xf /tmp/meshroom.tar.gz -C $2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -v "$SCRIPT_DIR/meshroom.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/meshroom.sh"
chmod +x "$2/meshroom.sh"


# app icon setup
cd $SCRIPT_DIR
cp "../assets/meshroom.png" "$2/meshroom.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Meshrooom" --version="2023.3" --latest_path="$2"/meshroom.sh --categories="meshrooom, 3d, tracking" --destination="$2" --icon="$2"/meshroom.png
echo "Desktop file created."

chmod -R 777 "$2/"
cat $2/*.desktop