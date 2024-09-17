echo "Installing $1 to $2 - $3"

version="$3"
mkdir -p /tmp/mrv2_install
cd /tmp/mrv2_install
wget -q -O /tmp/mrv2.tar.gz "$1"
chmod +x /tmp/mrv2.tar.gz
tar -xvf /tmp/mrv2.tar.gz -C /tmp/mrv2_install

cp -r /tmp/mrv2_install/mrv2-v$3-Linux-amd64/usr/local/mrv2-v$3-Linux-64/* $2/

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/mrv2.sh" "$2"/mrv2.sh
sed -i "s@ROOT_APP@$2/mrv2-v1.2.16-Linux-64/bin@g" "$2/mrv2.sh"
chmod +x "$2/mrv2.sh"

ln -sfv "$2/mrv2.sh" $2/latest
chmod +x $2/latest

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# app icon setup
cd $SCRIPT_DIR

cp ../assets/mrv2.png "$2"/mrv2.png
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="MRV2" --version="$3" --latest_path="$2"'/mrv2.sh "\\$@"' --categories="mrv2, sequence, player, images, exr, video" --destination=$2 --icon="$2"/mrv2.png
echo "Desktop file created."

chmod -R 777 $2/

cat $2/*.desktop