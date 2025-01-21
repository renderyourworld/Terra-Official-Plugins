echo "Installing filezilla..."
echo $1
echo $2

wget -q -O /tmp/filezilla.tar.xz "$1"
chmod +x /tmp/filezilla.tar.xz
#
echo "Extracting filezilla..."
tar -xvf /tmp/filezilla.tar.xz -C "$2"


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/filezilla.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/filezilla.sh"
chmod +x "$2/filezilla.sh"
chmod -R 777 "$2/"
## app icon setup
cd $SCRIPT_DIR
cp "../assets/filezilla.png" "$2/filezilla.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Filezilla" --version="3.6" --latest_path="$2"/filezilla.sh --categories="filezilla" --destination="$2" --icon="$2"/filezilla.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "$2/"
#cat $2/*.desktop
