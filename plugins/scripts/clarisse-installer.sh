# template for appimage
#echo "Installing clarisse..."
#wget -q -O /tmp/clarisse.appimage "$1"
#chmod +x /tmp/clarisse.appimage
#
#echo "Extracting clarisse..."
#/tmp/clarisse.appimage --appimage-extract > /dev/null
#mv ./squashfs-root "$2/"
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#cp -v "$SCRIPT_DIR/clarisse.sh" "$2/"
#sed -i "s@ROOT_APP@$2@g" "$2/clarisse.sh"
#chmod +x "$2/clarisse.sh"
#chmod -R 777 "$2/"
## app icon setup
#cd $SCRIPT_DIR
#cp "../assets/clarisse.png" "$2/clarisse.png"
#echo "Adding desktop file"
#chmod +X create_desktop_file.py
#python3 create_desktop_file.py --app_name="clarisse" --version="30.0" --latest_path="$2"/clarisse.sh --categories="clarisse" --destination="$2" --icon="$2"/clarisse.png --terminal="False"
#echo "Desktop file created."
#chmod -R 777 "$2/"
#cat $2/*.desktop
