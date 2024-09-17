echo "Installing ffmpeg..."
wget -q -O /tmp/ffmpeg.tar.xz https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
cd /tmp
mkdir ffmpeginstall
tar xvf ffmpeg.tar.xz -C /tmp/ffmpeginstall > /dev/null
temp_folder="/tmp/ffmpeginstall"
files=( "${temp_folder}"/*/ )
ffmpeg_installer_folder="${files[0]}"

echo $ffmpeg_installer_folder

mv $ffmpeg_installer_folder/* $2/


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/ffmpeg.sh" "$2/"
sed -i "s@ROOT_APP@$2@g" "$2/ffmpeg.sh"
chmod +x "$2/ffmpeg.sh"

# app icon setup
cd $SCRIPT_DIR
cp "../assets/ffmpeg.png" "$2/ffmpeg.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Ffmpeg" --version="3.0" --latest_path="$2"/ffmpeg.sh --categories="ffmpeg" --destination="$2" --icon="$2"/ffmpeg.png --terminal="True"
echo "Desktop file created."
chmod -R 777 "$2/"
