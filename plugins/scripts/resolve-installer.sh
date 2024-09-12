echo "Installing DaVinci Resolve $2 to $1"

echo "Required to remove old install"
rm -rf "$1"

if [ "$2" = "18" ]
then
  export resolve_version="DaVinci_Resolve_18.6.6_Linux"
else
  export resolve_version="DaVinci_Resolve_19.0.1_Linux"
fi

if [ "$DEV_APPS_DEBUG" = true ]
then
  # test is set to 18!
  cd /tmp
  mv /tmp/DaVinci_Resolve_18.6.6_Linux.zip /tmp/resolve.zip
else
  cd /tmp
  echo "Downloading Resolve ..."
  echo "Downloading from https://s3.eu-central-1.wasabisys.com/juno-deps/resolve/$resolve_version.zip"
  wget -q -O /tmp/resolve.zip "https://s3.eu-central-1.wasabisys.com/juno-deps/resolve/$resolve_version.zip"
fi

echo "Extracting Resolve..."
chmod +x /tmp/resolve.zip
mkdir -p /tmp/resolve_installer
mkdir -p "/var/BlackmagicDesign"
mkdir -p "/var/BlackmagicDesign/DaVinci Resolve"
mkdir -p $1

unzip /tmp/resolve.zip -d /tmp/resolve_installer > /dev/null
echo "Extracting Resolve done."

cd /tmp/resolve_installer
echo "Installing Resolve from .run file ..."
#./DaVinci_Resolve_18.6.6_Linux.run --install --noconfirm --nonroot --directory "$2"
./"$resolve_version".run --appimage-extract > /dev/null
mv -f /tmp/resolve_installer/squashfs-root/* "$1" > /dev/null

# copy install pdf
cp /tmp/resolve_installer/Linux_Installation_Instructions.pdf "$1/Linux_Installation_Instructions.pdf"
chmod -R 777 "$1/" > /dev/null

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/resolve.source.sh" "$1/"
cp -v "$SCRIPT_DIR/resolve.sh" "$1/"
sed -i "s@ROOT_APP@$2@g" "$1/resolve.sh"
chmod +x "$1/resolve.sh"
chmod +x "$1/resolve.source.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/resolve.png" "$1/resolve.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="DaVinci_Resolve" --version="$2" --latest_path="$1"/resolve.sh --categories="resolve, video editor" --destination="$1" --icon="$1"/resolve.png --terminal="True"
echo "Desktop file created."
chmod -R 777 "$1/" > /dev/null
cat $1/*.desktop

# cleanup
rm $1/AppRun.desktop




