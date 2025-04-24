set -e

echo "Installing $VERSION"
echo "Destination $DESTINATION"

curl -LJO -o nuke.tgz "https://www.foundry.com/products/download_product?file=$VERSION-linux-x86_64.tgz"
mv -v "download_product" "/tmp/$VERSION.tgz"

executable="$(echo "$VERSION" | cut -d'v' -f1)"
echo "Executable: $executable"

tar -xvf "/tmp/$VERSION.tgz" -C /tmp/
"/tmp/$1-linux-x86_64.run" --prefix="$DESTINATION/" --accept-foundry-eula

rm -rfv "$DESTINATION/$VERSION.tgz" "$DESTINATION/$VERSION-linux-x86_64.run"

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

