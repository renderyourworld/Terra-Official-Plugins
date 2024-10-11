# template for appimage
#echo "Installing templateapp..."
#wget -q -O /tmp/templateapp.appimage "$1"
#chmod +x /tmp/templateapp.appimage
#
#echo "Extracting templateapp..."
#/tmp/templateapp.appimage --appimage-extract > /dev/null
#mv ./squashfs-root "$2/"
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#cp -v "$SCRIPT_DIR/templateapp.sh" "$2/"
#sed -i "s@ROOT_APP@$2@g" "$2/templateapp.sh"
#chmod +x "$2/templateapp.sh"
#chmod -R 777 "$2/"
## app icon setup
#cd $SCRIPT_DIR
#cp "../assets/templateapp.png" "$2/templateapp.png"
#echo "Adding desktop file"
#chmod +X create_desktop_file.py
#python3 create_desktop_file.py --app_name="templateapp" --version="30.0" --latest_path="$2"/templateapp.sh --categories="templateapp" --destination="$2" --icon="$2"/templateapp.png --terminal="False"
#echo "Desktop file created."
#chmod -R 777 "$2/"
#cat $2/*.desktop
