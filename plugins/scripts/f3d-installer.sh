# template for appimage
#echo "Installing f3d..."
#wget -q -O /tmp/f3d.appimage "$1"
#chmod +x /tmp/f3d.appimage
#
#echo "Extracting f3d..."
#/tmp/f3d.appimage --appimage-extract > /dev/null
#mv ./squashfs-root "$2/"
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#cp -v "$SCRIPT_DIR/f3d.sh" "$2/"
#sed -i "s@ROOT_APP@$2@g" "$2/f3d.sh"
#chmod +x "$2/f3d.sh"
#chmod -R 777 "$2/"
## app icon setup
#cd $SCRIPT_DIR
#cp "../assets/f3d.png" "$2/f3d.png"
#echo "Adding desktop file"
#chmod +X create_desktop_file.py
#python3 create_desktop_file.py --app_name="f3d" --version="30.0" --latest_path="$2"/f3d.sh --categories="f3d" --destination="$2" --icon="$2"/f3d.png --terminal="False"
#echo "Desktop file created."
#chmod -R 777 "$2/"
#cat $2/*.desktop
