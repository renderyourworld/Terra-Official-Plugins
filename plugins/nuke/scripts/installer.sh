set -e

apt update
apt install curl -y

echo "Installing $VERSION"
echo "Destination $DESTINATION"

curl -LJO -o nuke.tgz "https://www.foundry.com/products/download_product?file=$VERSION-linux-x86_64.tgz"
mv -v "download_product" "/tmp/$VERSION.tgz"

executable="$(echo "$VERSION" | cut -d'v' -f1)"
echo "Executable: $executable"

tar -xvf "/tmp/$VERSION.tgz" -C /tmp/
"/tmp/$VERSION-linux-x86_64.run" --prefix="$DESTINATION/" --accept-foundry-eula

rm -rfv "$DESTINATION/$VERSION.tgz" "$DESTINATION/$VERSION-linux-x86_64.run"

# app icon setup
cp -v ./assets/nuke.png $DESTINATION/
cp -v ./assets/nuke.desktop $DESTINATION/

LAUNCH="$DESTINATION/$VERSION/$executable"
ICON="$DESTINATION/nuke.png"

sed -i -e 's/APP-VERSION/$VERSION/g' $DESTINATION/nuke.desktop
sed -i -e 's/DESTINATION-PATH/$LAUNCH/g' $DESTINATION/nuke.desktop
sed -i -e 's/ICON-PATH/$ICON/g' $DESTINATION/nuke.desktop

cat $DESTINATION/*.desktop

