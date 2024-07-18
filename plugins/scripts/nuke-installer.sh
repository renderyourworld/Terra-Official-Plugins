echo "Installing $1"

curl -LJO -o nuke.tgz "https://www.foundry.com/products/download_product?file=$1-linux-x86_64.tgz"
mv -v "download_product" "/tmp/$1.tgz"

executable="$(echo "$1" | cut -d'v' -f1)"
echo "Executable: $executable"
echo "Link: $2latest -> $2$1/$executable"

tar -xvf "/tmp/$1.tgz" -C /tmp/
"/tmp/$1-linux-x86_64.run" --prefix="$2" --accept-foundry-eula

rm -rfv "$2$1.tgz" "$2$1-linux-x86_64.run"
ln -sfv "$2$1/$executable" "$2latest"
