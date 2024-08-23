echo "Installing OCIO Configs..."

mkdir -p $2
mkdir -p $2/configs
cd $2/configs

echo "Downloading OCIO Configs..."
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/cg-config-v2.0.0_aces-v1.3_ocio-v2.1.ocio
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/cg-config-v2.0.0_aces-v1.3_ocio-v2.2.ocio
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/reference-config-v2.0.0_aces-v1.3_ocio-v2.1.ocio
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/reference-config-v2.0.0_aces-v1.3_ocio-v2.2.ocio
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/reference-config-v2.1.0_aces-v1.3_ocio-v2.3.ocio
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/studio-config-v2.0.0_aces-v1.3_ocio-v2.1.ocio
wget https://github.com/AcademySoftwareFoundation/OpenColorIO-Config-ACES/releases/download/v2.0.0/studio-config-v2.0.0_aces-v1.3_ocio-v2.2.ocio

echo "OCIO Configs downloaded."

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/ocio.sh.source" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/ocio.sh.source"
chmod +x "$2/ocio.sh.source"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/ocio.png" "$2/ocio.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="OCIO" --version="v2" --latest_path="$2"/ocio.sh.source --categories="ocio, color" --destination="$2" --icon="$2"/ocio.png
echo "Desktop file created."

cat $2/*.desktop
chmod -R 777 $2
ls $2/configs

echo "OCIO Configs installed. The configs are loaded trought a ENV VAR called OCIO. Read up more in the OCIO documentation."
echo "Polaris workstation will automaticaly load the OCIO configs in the environment once booted."
echo "OCIO is automaticaly set to studio-config-v2.0.0_aces-v1.3_ocio-v2.2.ocio"
