# template for appimage
#echo "Installing firefox..."
#wget -q -O /tmp/firefox.appimage "$1"
#chmod +x /tmp/firefox.appimage
#
#echo "Extracting firefox..."
#/tmp/firefox.appimage --appimage-extract > /dev/null
#mv ./squashfs-root "$2/"
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#cp -v "$SCRIPT_DIR/firefox.sh" "$2/"
#sed -i "s@ROOT_APP@$2@g" "$2/firefox.sh"
#chmod +x "$2/firefox.sh"
#chmod -R 777 "$2/"
## app icon setup
#cd $SCRIPT_DIR
#cp "../assets/firefox.png" "$2/firefox.png"
#echo "Adding desktop file"
#chmod +X create_desktop_file.py
#python3 create_desktop_file.py --app_name="Firefox" --version="30.0" --latest_path="$2"/firefox.sh --categories="firefox, web" --destination="$2" --icon="$2"/firefox.png --terminal="False"
#echo "Desktop file created."
#
#cat $2/*.desktop

echo "Installing Sample files..."
mkdir -p $2
cd $2
git clone https://github.com/AcademySoftwareFoundation/OpenImageIO-images.git
cd $2
git clone https://github.com/AcademySoftwareFoundation/openexr-images.git
#git clone https://github.com/DigitalProductionExampleLibrary/ALab.git
#git clone https://github.com/usd-wg/assets.git
chmod -R 777 $2/OpenImageIO-images
chmod -R 777 $2/openexr-images
#chmod -R 777 $2/ALab
#chmod -R 777 $2/assets
#
#wget -q -O /tmp/intel_moorelane_v1_2_0.zip "https://dpel-assets.aswf.io/4004-moore-lane/intel_moorelane_v1_2_0.zip"
#chmod +x /tmp/intel_moorelane_v1_2_0.zip
#mkdir -p $2/intel_moorelane_v1_2_0
#7z x /tmp/intel_moorelane_v1_2_0.zip -o$2/intel_moorelane_v1_2_0
#chmod -R 777 $2/intel_moorelane_v1_2_0
#
#mkdir -p $2/blender.org
#mkdir -p /tmp/blender
#cd /tmp/blender
#wget https://download.blender.org/institute/sybren/usd/03_035_A.lighting-viewport-settings.usdc.zip
#7z x 03_035_A.lighting-viewport-settings.usdc.zip
#wget https://download.blender.org/institute/sybren/usd/spring.runcycle.usdc
#
#cd $2
#ls -la
#chmod -R 777 $2/

chmod -R 777 "$2/"