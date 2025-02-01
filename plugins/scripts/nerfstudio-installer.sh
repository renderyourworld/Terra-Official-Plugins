echo "Installing NerfStudio..."







# app icon setup
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cp "../assets/nerfstudio.png" "$2/nerfstudio.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="nerfstudio" --version="1.1" --latest_path="$2"/nerfstudio.sh --categories="nerfstudio" --destination="$2" --icon="$2"/nerfstudio.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
