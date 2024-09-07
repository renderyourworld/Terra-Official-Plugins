echo "Installing games ..."
apt-get install p7zip-full -y > /dev/null

uncpak_root=/tmp/games_installs
mkdir -p /apps/games/diablo
mkdir -p $uncpak_root
mkdir -p $uncpak_root/isomount


wget -q -O /tmp/devilutionx.appimage https://github.com/diasurgical/devilutionX/releases/download/1.5.2/devilutionx-linux-x86_64.appimage
chmod +x /tmp/devilutionx.appimage

echo "Extracting DevilutionX ..."
/tmp/devilutionx.appimage --appimage-extract > /dev/null
mv ./squashfs-root /apps/games/diablo/

if [ "$DEV_APPS_DEBUG" = true ]
then
  ls /apps/games
  ls $uncpak_root
  # DIABDAT.MPQ
else
  echo "Not dev" wget the files
  wget -q -O /tmp/d1.iso "https://archive.org/download/Diablo_1996_Blizzard/Diablo%20%281996%29%28Blizzard%29.iso"
fi
chmod +x /tmp/d1.iso

7z x /tmp/d1.iso -o$uncpak_root/isomount
cp $uncpak_root/isomount/DIABDAT.MPQ /apps/games/diablo/squashfs-root/usr/bin/DIABDAT.MPQ
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/devilutionx.sh" /apps/games
sed -i "s@ROOT_APP@/apps/games/diablo@g" /apps/games/devilutionx.sh
chmod +x "/apps/games/devilutionx.sh"

#wget -q -O /tmp/keycars.zip "https://s3.eu-central-1.wasabisys.com/juno-deps/KeyCars_LINUX_1.3.zip"
#mkdir -p /apps/games/keycars
#7z x /tmp/keycars.zip -o/apps/games/keycars

# app icon setup
cd $SCRIPT_DIR
cp "../assets/devilutionx.png" "$2/devilutionx.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="DevilutionX" --version="1.0" --latest_path=/apps/games/devilutionx.sh --categories="devilutionx, games" --destination=/apps/games --icon="$2"/devilutionx.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "/apps/games/"
cat $2/*.desktop

echo "Cleaning up ..."
rm -rf /tmp/*.iso
rm -rf $uncpak_root/isomount

