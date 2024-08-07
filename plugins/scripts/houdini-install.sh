aws --version

echo "Installing $1 - $2  $3"
houdini_install_dir=$2
# We need to pass export SIDEFX_CLIENT_ID=''; export SIDEFX_CLIENT_SECRET=''; export DEV_APPS_DEBUG=true to the scipt itself
export SIDEFX_CLIENT_ID=$4
export SIDEFX_CLIENT_SECRET=$5
# same as versions
export HOUDINI_VERSION=$1
export HOUDINI_BUILD=$2
export SESI_HOST="hlicense"
echo "Setting up prequesites"
apt-get install bc -y
python3 -m venv venv
source venv/bin/activate
pip3 install requests
pip3 install click

export houdini_install_version="$HOUDINI_VERSION.$HOUDINI_BUILD"


temp_folder="/tmp/apps_temp"
mkdir -p $temp_folder
mkdir -p $temp_folder/$HOUDINI_VERSION.$HOUDINI_BUILD
mkdir -p $temp_folder/$HOUDINI_VERSION.$HOUDINI_BUILD/installs
temp_folder_version=$temp_folder/$HOUDINI_VERSION.$HOUDINI_BUILD

echo "Downloading Houdini $houdini_install_version"
python3 /opt/official-plugins/plugins/scripts/sidefx_downloader.py --version $HOUDINI_VERSION --build $HOUDINI_BUILD --key $SIDEFX_CLIENT_ID --secret $SIDEFX_CLIENT_SECRET --output $temp_folder_version
ls $temp_folder_version


echo "Extracting Houdini tar.gz"
chmod 777 $temp_folder_version/houdini.tar.gz
tar -xvf $temp_folder_version/houdini.tar.gz -C $temp_folder_version/installs > $temp_folder_version/houdini_extract.log
rm -rf $temp_folder_version/houdini.tar.gz

echo "Houdini tar.gz extracted to $temp_folder_version/installs"

# get gcc version

files=( "${temp_folder_version}"/installs/*/ )
hou_installer_folder="${files[0]}"
echo "Extracted Houdini version $hou_installer_folder"

echo "Installing Houdini..."
# get license date from file
export $(cat $hou_installer_folder/houdini.install | grep 'LICENSE_DATE=' | tr -d '"')
echo "License Date:" $LICENSE_DATE
#
cd $hou_installer_folder
./houdini.install --auto-install --install-menus --install-sidefxlabs --no-install-hfs-symlink --no-root-check  --no-install-bin-symlink --license-server-name $SESI_HOST --no-install-license --accept-EULA $LICENSE_DATE --install-dir $houdini_install_dir/houdini-$houdini_install_version > /tmp/houdini_install.log

echo "Create Houdini Version sh file $houdini_version"
cp houdini/run_houdini.sh $houdini_install_dir/run_houdini_$houdini_version.sh

### SED the version file
sed -i 's/VERSION.*/'"$houdini_version"'/g' $houdini_install_dir/run_houdini_$houdini_version.sh

cp houdini/splashscreen.png $houdini_install_dir/houdini-$houdini_install_version/splashscreen.png
chmod 777 $houdini_install_dir/houdini-$houdini_install_version/splashscreen.png
echo "Link: latest -> $houdini_version"
ln -sfv $houdini_install_dir/run_houdini_$houdini_version.sh $houdini_install_dir/latest
chmod +x $houdini_install_dir/latest
echo "Link to latest created."


