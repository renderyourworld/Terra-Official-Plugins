echo "Installing $1"

export houdini_install_version="$HOUDINI_VERSION.$HOUDINI_BUILD"

if [ "$DEV_APPS_DEBUG" = true ]
then
	echo "Dev Apps Debug is enabled"
  packaged_houdini_path=/mnt/data/tmp/apps_temp/packed/houdini_packed.tar.gz
  install_path=/mnt/data/apps/houdini/versions
  unpack_temp=/mnt/data/apps/houdini/versions_unpack
  unpacked_path=/mnt/data/apps/houdini/versions_unpack/mnt/data/tmp/apps_temp/installed
else
	packaged_houdini_path=/apps/houdini/houdini_packed.tar.gz
  install_path=/apps/houdini/versions
  unpack_temp=/apps/houdini/versions_unpack
  unpacked_path=/tmp/apps_temp/apps_temp/installed
fi

echo "Extracting Packed Houdini"
mkdir -p $unpack_temp
mkdir -p $install_path
chmod -R 777 $packaged_houdini_path $install_path
tar -xvf $packaged_houdini_path -C $unpack_temp > $unpack_temp/houdini_unpack.log


echo "Houdini tar.gz extracted to $unpack_temp"
houdini_version_path=`ls -d $unpacked_path/*houdini-*`
houdini_version=$(echo $houdini_version_path | cut -d"-" -f2 | tr -d "(")
houdini_version_for_directory_path=$install_path/$houdini_version
mkdir -p $houdini_version_for_directory_path
chmod -R 777 $houdini_version_for_directory_path

echo "Moving data from $unpacked_path to $houdini_version_for_directory_path"
cp -r $unpacked_path/* $houdini_version_for_directory_path
echo "Installed Houdini version"
ls $install_path

echo "Cleaning up temporary files and folders."
rm -rf $unpacked_path
rm -rf $unpack_temp


echo "Create Houdini Version sh file $$houdini_version"
cp houdini/run_houdini.sh /apps/houdini/versions/$houdini_version/run_houdini_$houdini_version.sh

### SED the version file
sed -i 's/VERSION.*/'"$houdini_version"'/g' /apps/houdini/versions/$houdini_version/run_houdini_$houdini_version.sh

cp houdini/splashscreen.png /apps/houdini/versions/$houdini_version/splashscreen.png
chmod 777 /apps/houdini/versions/$houdini_version/splashscreen.png
echo "Link: /apps/houdini/latest -> /apps/houdini/versions/$houdini_version"
ln -sfv /apps/houdini/versions/$houdini_version/run_houdini_$houdini_version.sh /apps/houdini/latest
chmod +x /apps/houdini/latest
echo "Link to latest created."
