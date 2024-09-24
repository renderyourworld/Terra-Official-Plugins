echo "Installing q2rtx..."
cd /tmp

if [ "$DEV_APPS_DEBUG" = true ]
then
  cd /tmp
else
  echo "Downloading Q2Rtx..."
  wget -q -O /tmp/q2rtx.tar.gz "$1"
fi

chmod +x /tmp/q2rtx.tar.gz

echo "Extracting q2rtx..."
tar -xvf /tmp/q2rtx.tar.gz -C "$2"/ > /dev/null

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/q2rtx.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/q2rtx.sh"
chmod +x "$2/q2rtx.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/q2rtx.png" "$2/q2rtx.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Q2Rtx" --version="1.7.0" --latest_path="$2"/q2rtx.sh --categories="q2rtx, game" --destination="$2" --icon="$2"/q2rtx.png --terminal="True"
echo "Desktop file created."

chmod -R 777 "$2/"
cat $2/*.desktop
