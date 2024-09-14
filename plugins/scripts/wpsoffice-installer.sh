echo "Installing $1 to $2"
cd /tmp
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
cp -r wps-desktop/*.png $2/
echo "Adding desktop file"

cp -r wps-desktop/*.desktop $2/
sed -i "s@ROOT_APP@$2/squashfs-root/wpsoffice@g" $2/wps-office-et.desktop
sed -i "s@ROOT_APP@$2/squashfs-root/wpsoffice@g" $2/wps-office-pdf.desktop
sed -i "s@ROOT_APP@$2/squashfs-root/wpsoffice@g" $2/wps-office-prometheus.desktop
sed -i "s@ROOT_APP@$2/squashfs-root/wpsoffice@g" $2/wps-office-wpp.desktop
sed -i "s@ROOT_APP@$2/squashfs-root/wpsoffice@g" $2/wps-office-wps.desktop

sed -i "s@Icon=wps-office2019-etmain@Icon=$2/wps-office2019-etmain.png@g" $2/wps-office-et.desktop
sed -i "s@Icon=wps-office2019-pdfmain@Icon=$2/wps-office2019-pdfmain.png@g" $2/wps-office-pdf.desktop
sed -i "s@Icon=wps-office2019-kprometheus@Icon=$2/wps-office2019-kprometheus.png@g" $2/wps-office-prometheus.desktop
sed -i "s@Icon=wps-office2019-wppmain@Icon=$2/wps-office2019-wppmain.png@g" $2/wps-office-wpp.desktop
sed -i "s@Icon=wps-office2019-wpsmain@Icon=$2/wps-office2019-wpsmain.png@g" $2/wps-office-wps.desktop


echo "Desktop file created."

cat $2/*.desktop


ls $2


