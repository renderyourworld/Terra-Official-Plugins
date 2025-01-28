echo "Installing f3d..."
wget -q -O /tmp/f3d.tar.gz "$1"
chmod +x /tmp/f3d.tar.gz

mkdir -p $2
chmod -R 777 $2

echo "Extracting f3d..."
tar xvf /tmp/f3d.tar.gz -C $2 &> /dev/null

files=( "$2"/*/ )
f3d_installer_folder="${files[0]}"
echo "Got version > $f3d_installer_folder"
full_path=$(realpath $f3d_installer_folder)
echo "Full path to bin > " $full_path
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/f3d.sh" "$2/"
sed -i "s@ROOT_APP@$full_path@g" "$2/f3d.sh"
chmod +x "$2/f3d.sh"
chmod -R 777 "$2"
## app icon setup
cd $SCRIPT_DIR
cp "../assets/f3d.png" "$2/f3d.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="F3d" --version="3.0" --latest_path="$2"/f3d.sh --categories="f3d" --destination="$2" --icon="$2"/f3d.png --terminal="True"

echo "Desktop file created."
chmod -R 777 "$2/"

