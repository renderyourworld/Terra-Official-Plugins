wget -q -O /tmp/blender-benchmark-script.tar.gz $1
wget -q -O /tmp/classroom.tar.bz2 https://ftp.nluug.nl/pub/graphics/blender/release/BlenderBenchmark2.0/scenes/classroom.tar.bz2
mkdir $2
chmod +x /tmp/blender-benchmark-script.tar.gz
tar -xzvf /tmp/blender-benchmark-script.tar.gz -C "$2"/ > /dev/null

chmod +x /tmp/classroom.tar.bz2
tar -xvjf /tmp/classroom.tar.bz2 -C "$2"/ > /dev/null

echo "/apps/blender/latest --background \
  --factory-startup \
  -noaudio \
  --debug-cycles \
  --enable-autoexec \
  --engine \
  CYCLES \
  ${2}/classroom/main.blend \
  --python \
  ${2}/blender-benchmark-script-2.0.0/main.py \
  -- \
  --device-type CPU" > "$2"/blenderbenchmark.sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sed -i "s@ROOT_APP@$2@g" "$2"/blenderbenchmark.sh
chmod +x "$2"/blenderbenchmark.sh

# app icon setup
cd $SCRIPT_DIR
cp "../assets/blenderbenchmark.png" "$2/blenderbenchmark.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Blender Benchmark" --version="1.0" --latest_path="$2"/blenderbenchmark.sh --categories="cpux, cpu, system" --destination="$2" --icon="$2"/blenderbenchmark.png
echo "Desktop file created."

cat $2/*.desktop
chmod -R 777 "$2/"