echo "Installing Blender $1 - $2 ..."

# split 4.2.0 to 4.2
version=$(echo $1 | cut -d'.' -f1-2)

if [ "$DEV_APPS_DEBUG" = true ]
then
  cd /tmp
else
  echo "Downloading Blender..."
  wget -q -O /tmp/blender-$1-linux-x64.tar.xz "https://mirror.clarkson.edu/blender/release/Blender$version/blender-$1-linux-x64.tar.xz"
fi

echo "Extracting Blender..."
tar -xvf /tmp/blender-$1-linux-x64.tar.xz -C "$2"/ > /dev/null
# blender-$1-linux-x64
ln -sfv "$2/blender-$1-linux-x64/blender" "$2/latest"


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/blender.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/blender.sh"
chmod +x "$2/blender.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/blender.png" "$2/blender.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Blender" --version=$version --latest_path="$2"/blender.sh --categories="blender, render" --destination="$2" --icon="$2"/blender.png
echo "Desktop file created."
chmod -R 777 "$2/"
cat $2/*.desktop
