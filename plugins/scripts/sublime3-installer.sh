echo "Installing Sublime3 $1 to $2"

wget -q -O /tmp/meshroom.tar.gz "$1"
tar vxjf /tmp/meshroom.tar.gz -C $2
# Move the uncompressed files to an appropriate location.
chmod -R 777 "$2/"
install_dir=$2

ls $install_dir

# Create a symbolic link for the desktop entry.
#ln -s $install_dir/sublime_text_3/sublime_text.desktop /usr/share/applications/sublime_text.desktop


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# app icon setup
cd $SCRIPT_DIR
cp "../assets/sublime3.png" "$2/sublime3.png"
echo "Adding desktop file"

cp $install_dir/sublime_text_3/sublime_text.desktop $2/sublime_text.desktop
sed -i "s@/opt/sublime_text@$2/sublime_text_3@g" $2/sublime_text.desktop
sed -i "s@Categories=@Categories=X-Polaris;@g" $2/sublime_text.desktop
sed -i "s@Icon=sublime-text@Icon=$2/sublime3.png@g" $2/sublime_text.desktop
sed -i "s@GenericName=Text Editor@GenericName=Sublime 3 Text Editor@g" $2/sublime_text.desktop

echo "Desktop file created."

cat $2/*.desktop