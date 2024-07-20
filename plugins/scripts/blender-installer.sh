echo "Installing Blender $1"

# split 4.2.0 to 4.2
version=$(echo $1 | cut -d'.' -f1-2)

curl -LJO "https://mirror.clarkson.edu/blender/release/Blender$version/blender-$1-linux-x64.tar.xz"
tar -xvf blender-*.tar.xz -C "$2"
blender-$1-linux-x64
ln -sfv "$2blender-$1-linux-x64/blender" "$2latest"
