echo "Installing $1 to $2"
install_dir=$2
mkdir -p $install_dir
mkdir -p $install_dir/sublime_text_install
cd $install_dir/sublime_text_install
curl -L -O --output-dir $install_dir/sublime_text_install https://download.sublimetext.com/sublime_text_3_build_3211_x64.tar.bz2
tar vxjf sublime_text_3_build_*_x64.tar.bz2
# Move the uncompressed files to an appropriate location.
sudo mv sublime_text_3 $install_dir

ls $install_dir

# Create a symbolic link for the desktop entry.
ln -s $install_dir/sublime_text_3/sublime_text.desktop /usr/share/applications/sublime_text.desktop