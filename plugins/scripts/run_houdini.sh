# setup user folder
echo "Setting up user folder"

# check lates versino linked for houdini
houdini_version_path=`ls -la /apps/houdini/latest`
houdini_version=$(echo $houdini_version_path | cut -d"/" -f8)
houdini_version_short=`echo $houdini_version | cut -d"." -f1,2`
houdini_in_home_folder="$HOME/houdini$houdini_version_short"


# check if we have houdini setup
if [ ! -f $houdini_in_home_folder/houdini.env ]; then
    mkdir -p $houdini_in_home_folder
    # setup env
    touch $houdini_in_home_folder/houdini.env
    echo "HOUDINI_PATH=/apps/houdini/versions/$houdini_version/houdini-$houdini_version/houdini" >> $houdini_in_home_folder/houdini.env
    #echo "HOUDINI_PACKAGE_DIR=/apps/houdini/versions/$houdini_version/sidefx_packages" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_SPLASH_FILE=/apps/houdini/versions/$houdini_version/splashscreen.png" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_SPLASH_MESSAGE='Welcome $USER @ $HOSTNAME $houdini_version'" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_PACKAGE_VERBOSE=1" >> $houdini_in_home_folder/houdini.env
    #echo "HOUDINI_DISABLE_SIDEFX_PACKAGES=0" >> $houdini_in_home_folder/houdini.env

    # add more env VARS here
    # setup OCIO if found in env

    # setup license server prefs
    touch $HOME/.sesi_licenses.pref
    echo "serverhost=10.0.5.10:1715" >> $HOME/.sesi_licenses.pref

    # set permissions
    chmod -R 777 $houdini_in_home_folder $HOME/.sesi_licenses.pref
    chown -R $USER:$USER $houdini_in_home_folder

    echo "User prefs for Houdini installed."
    # setup icons in Desktop

    echo "[Desktop Entry]
Name=Houdini $houdini_version
Exec=terminator -x /apps/houdini/latest
Terminal=true
Type=Application
Categories=Polaris" > /apps/houdini/versions/houdini.desktop
fi

houdini_python=/apps/houdini/versions/$houdini_version/houdini-$houdini_version/python/lib/python3.10/site-packages
export PYTHONPATH="$PYTHONPATH:/apps/houdini/versions/$houdini_version/houdini-$houdini_version/houdini/python310/lib/site-packages"

pushd /apps/houdini/versions/$houdini_version/houdini-$houdini_version
source houdini_setup
houdini
