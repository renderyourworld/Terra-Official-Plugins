echo "Installing $1 - $2  $3"

echo "Setting up prequesites"
apt-get install bc -y
python3 -m venv venv
source venv/bin/activate
pip3 install requests
pip3 install click

# We need to pass export SIDEFX_CLIENT_ID=''; export SIDEFX_CLIENT_SECRET=''; export DEV_APPS_DEBUG=true to the scipt itself
export houdini_install_dir=$3
export SIDEFX_CLIENT_ID=$4
export SIDEFX_CLIENT_SECRET=$5
# same as versions
export HOUDINI_VERSION=$1
export HOUDINI_BUILD=$2
export SESI_HOST="hlicense"
export houdini_install_version="$HOUDINI_VERSION.$HOUDINI_BUILD"

temp_folder="/tmp/apps_temp"
mkdir -p $temp_folder
mkdir -p "$temp_folder"/"$houdini_install_version"
mkdir -p "$temp_folder"/"$houdini_install_version"/installs
temp_folder_version="$temp_folder"/"$houdini_install_version"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Downloading Houdini $houdini_install_version"
if [ "$DEV_APPS_DEBUG" = true ]
then
	echo "Dev Apps Debug is enabled"
	ls /tmp
  cp /tmp/houdini.tar.gz $temp_folder_version/houdini.tar.gz
  chmod +x $temp_folder_version/houdini.tar.gz
  ls $temp_folder_version
else
  python3 "$SCRIPT_DIR/sidefx_downloader.py" --version $HOUDINI_VERSION --build $HOUDINI_BUILD --key $SIDEFX_CLIENT_ID --secret $SIDEFX_CLIENT_SECRET --output $temp_folder_version
fi

echo "Extracting Houdini tar.gz"
chmod 777 $temp_folder_version/houdini.tar.gz
tar -xvf $temp_folder_version/houdini.tar.gz -C $temp_folder_version/installs > $temp_folder_version/houdini_extract.log
rm -rf $temp_folder_version/houdini.tar.gz
echo "Houdini.tar.gz extracted to $temp_folder_version/installs"

# get gcc version
files=( "${temp_folder_version}"/installs/*/ )
hou_installer_folder="${files[0]}"


echo "Installing Houdini... $houdini_install_dir ..."
# get license date from file
export $(cat $hou_installer_folder/houdini.install | grep 'LICENSE_DATE=' | tr -d '"')
echo "License Date:" $LICENSE_DATE

cd $hou_installer_folder
./houdini.install --auto-install --install-menus --install-sidefxlabs --no-install-hfs-symlink --no-root-check  --no-install-bin-symlink --license-server-name $SESI_HOST --no-install-license --accept-EULA $LICENSE_DATE --install-dir $houdini_install_dir/houdini-$houdini_install_version > /tmp/houdini_install.log

echo "Create Houdini Version sh file $houdini_install_version"
runner_file="$houdini_install_dir"run_houdini_"$houdini_install_version.sh"

python3 $SCRIPT_DIR/houdini_create_run_file.py --houdini_install_dir=$houdini_install_dir --houdini_version=$houdini_install_version --serverhost=$hlicense --path=$runner_file

# setup splashscreen
cp $SCRIPT_DIR/houdini_splashscreen.png "$houdini_install_dir"splashscreen.png
chmod 777 "$houdini_install_dir"splashscreen.png

# LINK IT!
ls /apps/houdini/
latestlink="$houdini_install_dir"latest
echo "Link: latest -> $houdini_install_version"
echo "Linking $runner_file to $latestlink"
ln -sfv $runner_file latestlink
chmod +x $runner_file
echo "Link to latest created."

echo "Adding desktop file"
python3 $SCRIPT_DIR/create_desktop_file.py --app_name="Houdini" --version=$houdini_install_version --latest_path="$houdini_install_dir"latest --categories="3d, vfx"
ls /apps/applications
echo "Desktop file created."



