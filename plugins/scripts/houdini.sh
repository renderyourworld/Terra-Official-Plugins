# setup user folder
echo "Setting up user folder"
# check lates version linked for houdini
houdini_install_dir=ROOT_APP
houdini_version="APPVERSION"
houdini_version_short="APPBUILD"
houdini_ver_build="$houdini_version"."$houdini_version_short"
houdini_in_home_folder="$HOME/houdini"$houdini_version

# check if we have houdini setup
if [ ! -f $houdini_in_home_folder/houdini.env ]; then
    mkdir -p $houdini_in_home_folder
    # setup env
    touch $houdini_in_home_folder/houdini.env
    echo "HOUDINI_PATH=$houdini_install_dir/houdini" >> $houdini_in_home_folder/houdini.env
    #echo "HOUDINI_PACKAGE_DIR=/apps/houdini/versions/$houdini_version/sidefx_packages" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_SPLASH_FILE=$houdini_install_dir/splashscreen.png" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_SPLASH_MESSAGE='Welcome $USER @ $HOSTNAME $houdini_version'" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_PACKAGE_VERBOSE=1" >> $houdini_in_home_folder/houdini.env
    #echo "HOUDINI_DISABLE_SIDEFX_PACKAGES=0" >> $houdini_in_home_folder/houdini.env

    # add more env VARS here
    # setup OCIO if found in env

    # setup license server prefs
    touch $HOME/.sesi_licenses.pref
    echo "serverhost=APPSERVERHOST" >> $HOME/.sesi_licenses.pref

    # set permissions
    chmod -R 777 $houdini_in_home_folder $HOME/.sesi_licenses.pref
    chown -R $USER:$USER $houdini_in_home_folder

    echo "User prefs for Houdini installed."

houdini_python=$houdini_install_dir/python/lib/python3.10/site-packages
export PYTHONPATH="$PYTHONPATH":"$houdini_install_dir"/houdini/python310/lib/site-packages

cd $houdini_install_dir
source houdini_setup
houdini