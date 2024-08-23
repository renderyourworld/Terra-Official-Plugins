echo "Installing $1 - $2  $3"

echo "Setting up prequesites"
apt update -y
apt install apt-utils -y
apt install bc sudo -y
python3 -m venv venv
source venv/bin/activate
pip3 install requests
pip3 install click

# We need to pass export SIDEFX_CLIENT_ID=''; export SIDEFX_CLIENT_SECRET=''; export DEV_APPS_DEBUG=true to the scipt itself

export SIDEFX_CLIENT_ID=$4
export SIDEFX_CLIENT_SECRET=$5
# same as versions
export HOUDINI_VERSION=$1
export HOUDINI_BUILD=$2
export SESI_HOST="hlicense"
export houdini_install_version="$HOUDINI_VERSION.$HOUDINI_BUILD"
export houdini_install_dir=$3/"$HOUDINI_VERSION.$HOUDINI_BUILD"

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


mkdir -p $houdini_install_dir
chmod -R 777 $houdini_install_dir
echo "Houdini Install Dir: $houdini_install_dir"

# get license date from file
export $(cat $hou_installer_folder/houdini.install | grep 'LICENSE_DATE=' | tr -d '"')
echo "License Date:" $LICENSE_DATE

cd $hou_installer_folder
# sed -i "s@sudo @@g" hqueue.install
mkdir -p $3/hq_server $3/hq_client $3/hqueue_shared
chmod -R 777 $3/hq_server $3/hq_client $3/hqueue_shared

# --install-hqueue-client --hqueue-client-dir $3/hq_client --hqueue-server-name "hq-server" --hqueue-client-user "polaris-render-node" \
# --install-hqueue-server --hqueue-server-dir $3/hq_server --hqueue-shared-dir $3/hqueue_shared --hqueue-server-port 45000 \

./houdini.install --auto-install --install-menus --install-sidefxlabs --sidefxlabs-dir $houdini_install_dir --no-install-hfs-symlink --no-root-check \
--no-install-bin-symlink \
--license-server-name $SESI_HOST --no-install-license --accept-EULA $LICENSE_DATE \
--make-dir $houdini_install_dir \
--install-dir $houdini_install_dir > $3/houdini_install.log


# save stuff from install
cp -r $HOME/.local/share/applications/sesi_*.desktop $3

shopt -s nullglob
cd $3 && echo $PWD
# rewrite categories for XDG comaptibility
for i in *.desktop;
do
  echo "$i"
  sed -i "s/Categories=.*/Ccategories=X-Houdini;X-Polaris/g" $i
done
mkdir -p $houdini_install_dir/sesi
cp -r /usr/lib/sesi $houdini_install_dir

echo "Create Houdini Version sh file $houdini_install_version"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
runner_file=$houdini_install_dir/run_houdini_"$houdini_install_version".sh

# setup splashscreen
cp houdini_splashscreen.png $houdini_install_dir/splashscreen.png
cp -v $SCRIPT_DIR/houdini.sh $runner_file
sed -i "s@ROOT_APP@$houdini_install_dir@g" $runner_file
sed -i "s@APPVERSION@$HOUDINI_VERSION@g" $runner_file
sed -i "s@APPBUILD@$HOUDINI_BUILD@g" $runner_file
sed -i "s@APPSERVERHOST@$SESI_HOST@g" $runner_file
chmod +x $runner_file

# app icon setup
cp "../assets/houdini.png" "$houdini_install_dir/houdini.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Houdini" --version=$houdini_install_version --latest_path=$runner_file --categories="houdini, 3d" --destination=$houdini_install_dir --icon=$houdini_install_dir/houdini.png
echo "Desktop file created."
chmod -R 777 $3/


