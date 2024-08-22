echo "Installing $1 to $2"
wget -q -O /tmp/wpsoffice.appimage "$1"
chmod +x /tmp/wpsoffice.appimage
/tmp/wpsoffice.appimage --appimage-extract > /dev/null
mv ./squashfs-root "$2/"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
chmod -R 777 "$2/"

echo "Installing fonts"
mkdir -p /tmp/getfonts
cd /tmp/getfonts
git clone https://github.com/iykrichie/wps-office-19-missing-fonts-on-Linux.git
cd "wps-office-19-missing-fonts-on-Linux"
ls -la
mkdir -p $2/wps-fonts
mv WEBDINGS.TTF WEBDINGS.ttf
cp *.ttf $2/wps-fonts
chmod -R 777 $2/wps-fonts

# app icon setup
cd $SCRIPT_DIR
cp ../assets/wpsoffice.png "$2"/wpsoffice.png
echo "Adding desktop file"
cp $2/squashfs-root/WPS-Office.desktop $2/WPS-Office.desktop
sed -i "s@AppRun@$2/squashfs-root/AppRun@g" $2/WPS-Office.desktop
cho "Desktop file created."

cat $2/*.desktop


ls $2


