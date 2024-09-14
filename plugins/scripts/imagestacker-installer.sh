echo "Installing imagestacker..."
wget -q -O /tmp/imagestacker.zip "$1"
wget -q -O /tmp/imagestacker_dcc_support.zip "https://emildohne.com/wp-content/uploads/ImageStacker_1.0.0_DCC_Configs.zip"

cd /tmp
unzip imagestacker.zip
unzip imagestacker_dcc_support.zip
mv /tmp/ImageStacker $2
mv /tmp/dcc_configs $2/ImageStacker/dcc_configs

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/imagestacker.sh" "$2/"
cp -v "$SCRIPT_DIR/imagestacker_cli.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/imagestacker.sh"
sed -i "s@ROOT_APP@$2@g" "$2/imagestacker_cli.sh"
chmod +x "$2/imagestacker.sh"
chmod +x "$2/imagestacker_cli.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/imagestacker.png" "$2/imagestacker.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Imagestacker" --version="3.0" --latest_path="$2"/imagestacker.sh --categories="imagestacker" --destination="$2" --icon="$2"/imagestacker.png --terminal="True"
python3 create_desktop_file.py --app_name="ImagestackerCli" --version="3.0" --latest_path="$2"/imagestacker.sh --categories="imagestacker" --destination="$2" --icon="$2"/imagestacker.png --terminal="True"
echo "Desktop file created."
chmod -R 777 "$2/"