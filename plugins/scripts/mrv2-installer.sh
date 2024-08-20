echo "Installing $1 to $2"

mrv2_dir=$2
mkdir -p $mrv2_dir

wget -q -O /tmp/mrv2.tar.gz "$1"
tar -xvf /tmp/mrv2.tar.gz -C $mrv2_dir > /dev/null

mv $mrv2_dir/mrv2-v1.2.1-Linux-amd64/usr/local/mrv2-v1.2.1-Linux-64 $mrv2_dir/1.2.1
rm -rf $mrv2_dir/mrv2-v1.2.1-Linux-amd64
echo "Link: $mrv2_dir/latest -> $mrv2_dir/mrv2"

touch $mrv2_dir/1.2.1/run_mrv2.sh
echo "pushd $mrv2_dir/1.2.1/bin
./mrv2.sh" > $mrv2_dir/1.2.1/run_mrv2.sh

chmod +x $mrv2_dir/1.2.1/run_mrv2.sh

ln -sfv "$mrv2_dir/1.2.1/run_mrv2.sh" $mrv2_dir/latest
chmod +x $mrv2_dir/latest

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# app icon setup
cd $SCRIPT_DIR
cp ../assets/mrv2.png "$2"/mrv2.png
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Mrv2" --version="1.2.1" --latest_path=$mrv2_dir/latest --categories="mrv2, sequence, player, images, exr" --destination=$mrv2_dir --icon="$2"/mrv2.png
echo "Desktop file created."

cat $2/*.desktop