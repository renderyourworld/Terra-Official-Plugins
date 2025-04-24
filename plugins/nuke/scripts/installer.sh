set -e

echo "Installing $VERSION"
echo "Destination $DESTINATION"
#
#curl -LJO -o nuke.tgz "https://www.foundry.com/products/download_product?file=$1-linux-x86_64.tgz"
#mv -v "download_product" "/tmp/$VERSION.tgz"
#
#executable="$(echo "$1" | cut -d'v' -f1)"
#echo "Executable: $executable"
#
#tar -xvf "/tmp/$1.tgz" -C /tmp/ > /dev/null
#"/tmp/$1-linux-x86_64.run" --prefix="$2/" --accept-foundry-eula > /dev/null
#
#rm -rfv "$2/$1.tgz" "$2/$1-linux-x86_64.run"
#ln -sfv "$2/$1/$executable" "$2/latest"
#
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#
## app icon setup
#cd $SCRIPT_DIR
#cp "../assets/nuke.png" "$2/nuke.png"
#echo "Adding desktop file"
#chmod +X create_desktop_file.py
#python3 create_desktop_file.py --app_name="Nuke" --version=$1 --latest_path="$2"/latest --categories="nuke, compositing" --destination="$2" --icon="$2"/nuke.png --terminal="False"
#echo "Desktop file created."
#
#cat $2/*.desktop

