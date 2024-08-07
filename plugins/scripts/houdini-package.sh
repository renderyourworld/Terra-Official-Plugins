aws --version

echo "Installing $1 - $2"
# We need to pass export SIDEFX_CLIENT_ID=''; export SIDEFX_CLIENT_SECRET=''; export DEV_APPS_DEBUG=true to the scipt itself
# same as versions
#export "HOUDINI_VERSION"="20.0"
#export "HOUDINI_BUILD"="688"
#export "SESI_HOST"='hlicense'
echo "Setting up prequesites"
apt-get install bc -y
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

export houdini_install_version="$HOUDINI_VERSION.$HOUDINI_BUILD"

mkdir -p /apps/houdini/versions


temp_folder="/tmp/apps_temp"
mkdir -p $temp_folder
mkdir -p $temp_folder/installs

echo "Downloading Houdini $houdini_install_version"

if [ "$DEV_APPS_DEBUG" = true ]
then
	echo "Dev Apps Debug is enabled."
	#python downloader.py --version $HOUDINI_VERSION --build $HOUDINI_BUILD --key $SIDEFX_CLIENT_ID --secret $SIDEFX_CLIENT_SECRET
	#cp ~/Desktop/houdini-20.0.688-linux_x86_64_gcc9.3.tar.gz /apps/houdini/houdini.tar.gz
	temp_folder="/mnt/data/tmp/apps_temp"
	mkdir -p $temp_folder
  mkdir -p $temp_folder/installs
	cp /mnt/data/tmp/houdini-20.0.688-linux_x86_64_gcc11.2.tar.gz $temp_folder/houdini.tar.gz
	echo "Local files copied."
else
  echo "Downloading Houdini..."
	python3 houdini/downloader.py --version $HOUDINI_VERSION --build $HOUDINI_BUILD --key $SIDEFX_CLIENT_ID --secret $SIDEFX_CLIENT_SECRET --output $temp_folder
	ls $temp_folder
fi

echo "Extracting Houdini tar.gz"
chmod 777 $temp_folder/houdini.tar.gz
tar -xvf $temp_folder/houdini.tar.gz -C $temp_folder/installs > $temp_folder/houdini_extract.log
rm -rf $temp_folder/houdini.tar.gz

echo "Houdini tar.gz extracted to $temp_folder/installs"

# get gcc version

files=( "${temp_folder}"/installs/*/ )
hou_installer_folder="${files[0]}"
echo "Extracted Houdini version $hou_installer_folder"

echo "Installing Houdini..."
# get license date from file
export $(cat $hou_installer_folder/houdini.install | grep 'LICENSE_DATE=' | tr -d '"')
echo "License Date:" $LICENSE_DATE
#
cd $hou_installer_folder
./houdini.install --auto-install --install-menus --install-sidefxlabs --no-install-hfs-symlink --no-root-check  --no-install-bin-symlink --license-server-name $SESI_HOST --no-install-license --accept-EULA $LICENSE_DATE --make-dir $temp_folder/installed/houdini-$houdini_install_version --install-dir $temp_folder/installed/houdini-$houdini_install_version > /tmp/houdini_install.log
# update-edit paths so it matches when we launch houdini on the workstation

echo "Edit packages dir - update"
json_edit=$temp_folder/installed/houdini-$houdini_install_version/packages/package_dirs.json
# /apps/houdini/versions/20.0.688/sidefx_packages/
sed -i --expression "s@/mnt/data/tmp/apps_temp/installed/@/apps/houdini/versions/$houdini_install_version/@" $json_edit

# pack the installed houdini version
echo "Packing the installed Houdini version from $temp_folder/installed ..."

folder_for_packing=$temp_folder/installed/
mkdir -p $temp_folder/packed
tar -zvcf $temp_folder/packed/houdini_packed.tar.gz $folder_for_packing > $temp_folder/houdini_build.log
echo "Packing done."

# UPLOAD TO S3 HERE!
ls $temp_folder/packed/
if [ "$DEV_APPS_DEBUG" = true ]
then
	echo "Dev Apps Debug is enabled. No aws sync. No delete temp folder"
else
  aws s3 sync "$temp_folder/packed/" "s3://junofx-apps/houdini/" > /tmp/houdini_sync.log
  echo "Cleanup."
  rm -rf $temp_folder
fi




