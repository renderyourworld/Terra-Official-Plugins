echo "Installing pycharm-community-$1"

wget -q -O /tmp/pycharm-community-$1.tar.gz "https://download.jetbrains.com/python/pycharm-community-$1.tar.gz"
chmod +x /tmp/pycharm-community-$1.tar.gz

mkdir -p $2
chmod -R 777 $2

echo "Extracting pycharm-community-$1"
tar xzvf /tmp/pycharm-community-$1.tar.gz -C "$2"/
chmod -R 777 "$2"/pycharm-community-$1

chmod -R 777 "$2"/pycharm-community-$1
chmod -R 777 "$2"

ln -sfv "$2"/pycharm-community-$1/bin/pycharm.sh "$2"/latest

ls -l "$2"/
ls -l "$2"/pycharm-community-$1

# app icon setup
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cp "../assets/pycharm.png" "$2/pycharm.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Pycharm" --version=$1 --latest_path="$2/latest" --categories="pycharm, ide" --destination="$2" --icon="$2"/pycharm.png
echo "Desktop file created."

chmod -R 777 "$2"

cat $2/*.desktop
