import os
import click

@click.command()
@click.option("--houdini_version", default="20.0.668", help="Set Houdini version, default is 20.0")
@click.option("--houdini_install_dir", default="/apps/houdini", help="installation directory")
@click.option("--serverhost", default="None")
@click.option("--path_runfile", default="None")
@click.option("--debug", default="None")
def create_sh_file(houdini_install_dir=None, houdini_version=None, serverhost=None, path_runfile=None, debug=None):
    if debug:
        houdini_install_dir = "/home/des/_juno/Terra-Official-Plugins/.apps/houdini"
        path_runfile = "/home/des/_juno/Terra-Official-Plugins/.apps/houdini/run_houdini.sh"
        houdini_version = "20.0.668"
        serverhost = "None"

    houdini_version_short = houdini_version.split(".")[0]+"."+houdini_version.split(".")[1]

    houdini_run_file = f'''# setup user folder
echo "Setting up user folder"
# check lates version linked for houdini
houdini_install_dir="{houdini_install_dir}"
houdini_version="{houdini_version}"
houdini_version_short="{houdini_version_short}"
houdini_in_home_folder="$HOME/houdini{houdini_version_short}"

# check if we have houdini setup
if [ ! -f $houdini_in_home_folder/houdini.env ]; then
    mkdir -p $houdini_in_home_folder
    # setup env
    touch $houdini_in_home_folder/houdini.env
    echo "HOUDINI_PATH={houdini_install_dir}/$houdini_version/houdini-$houdini_version/houdini" >> $houdini_in_home_folder/houdini.env
    #echo "HOUDINI_PACKAGE_DIR=/apps/houdini/versions/$houdini_version/sidefx_packages" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_SPLASH_FILE=HOUDINI_INSTALLED_PATH/$houdini_version/splashscreen.png" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_SPLASH_MESSAGE='Welcome $USER @ $HOSTNAME $houdini_version'" >> $houdini_in_home_folder/houdini.env
    echo "HOUDINI_PACKAGE_VERBOSE=1" >> $houdini_in_home_folder/houdini.env
    #echo "HOUDINI_DISABLE_SIDEFX_PACKAGES=0" >> $houdini_in_home_folder/houdini.env

    # add more env VARS here
    # setup OCIO if found in env

    # setup license server prefs
    touch $HOME/.sesi_licenses.pref
    echo "serverhost={serverhost}" >> $HOME/.sesi_licenses.pref

    # set permissions
    chmod -R 777 $houdini_in_home_folder $HOME/.sesi_licenses.pref
    chown -R $USER:$USER $houdini_in_home_folder

    echo "User prefs for Houdini installed."

houdini_python={houdini_install_dir}/$houdini_version/houdini-$houdini_version/python/lib/python3.10/site-packages
export PYTHONPATH="$PYTHONPATH:{houdini_install_dir}/$houdini_version/houdini-$houdini_version/houdini/python310/lib/site-packages"

cd HOUDINI_INSTALLED_PATH/$houdini_version/houdini-$houdini_version
source houdini_setup
houdini
'''
    with open(f"{path_runfile}", "w") as f:
        f.write(houdini_run_file)