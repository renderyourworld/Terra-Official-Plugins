echo "Installing $1 to $2"

mrv2_dir=/tmp/mrv2_install
mkdir -p $mrv2_dir
cd /tmp
wget -O /tmp/mrv2.tar.gz "$1"
tar -xvf /tmp/mrv2.tar.gz -C $mrv2_dir
ls $mrv2_dir

mv $mrv2_dir/mrv2-v1.2.6-Linux-amd64/usr/local/mrv2-v1.2.6-Linux-64 $2

echo "Link: $2/latest -> $2/mrv2"

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
python3 create_desktop_file.py --app_name="Mrv2" --version="1.2.1" --latest_path='"$2"/run_mrv2.sh "\\$@"' --categories="mrv2, sequence, player, images, exr, video" --destination=$2 --icon="$2"/mrv2.png
echo "Desktop file created."

chmod -R 777 $2/
cat $2/*.desktop