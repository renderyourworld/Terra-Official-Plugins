echo "Installing Davinci Resolve to $2"

if [ "$DEV_APPS_DEBUG" = true ]
then
  cd /tmp
  mv /tmp/DaVinci_Resolve_18.6.6_Linux.zip /tmp/resolve.zip
else
  echo "Downloading Resolve ..."
  wget -q -O /tmp/resolve.zip "$1"
fi

echo "Extracting Resolve..."
chmod +x /tmp/resolve.zip
mkdir -p /apps/tmp/resolve_installer
mkdir -p "/var/BlackmagicDesign"
mkdir -p "/var/BlackmagicDesign/DaVinci Resolve"

unzip resolve.zip -d /apps/tmp/resolve_installer
echo "Extracting Resolve done."

cd /apps/tmp/resolve_installer
echo "Installing Resolve from .run file ..."
./DaVinci_Resolve_18.6.6_Linux.run --install --noconfirm --nonroot --directory "$2"

chmod -R 777 "$2/"


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/resolve.source.sh" "$2/"
cp -v "$SCRIPT_DIR/resolve.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/resolve.sh"
chmod +x "$2/resolve.sh"
chmod +x "$2/resolve.source.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/resolve.png" "$2/resolve.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Davinci Resolve" --version="18.6.6" --latest_path="$2"/resolve.sh --categories="resolve, video editor" --destination="$2" --icon="$2"/resolve.png --terminal="True"
echo "Desktop file created."

chmod -R 777 "$2/"

cat $2/*.desktop
