wget -q -O /tmp/blender-benchmark-script.tar.gz $1
wget -q -O /tmp/classroom.tar.bz2 https://ftp.nluug.nl/pub/graphics/blender/release/BlenderBenchmark2.0/scenes/classroom.tar.bz2
mkdir $2
chmod +x /tmp/blender-benchmark-script.tar.gz
tar -xzvf /tmp/blender-benchmark-script.tar.gz -C "$2" > /dev/null

chmod +x /tmp/classroom.tar.bz2
tar -xvjf /tmp/classroom.tar.bz2 -C "$2" > /dev/null

ls "$2"classroom
ls "$2"blender-benchmark-script-2.0.0

echo "/apps/blender/latest --background \
  --factory-startup \
  -noaudio \
  --debug-cycles \
  --enable-autoexec \
  --engine \
  CYCLES \
  ${2}clasroom/main.blend \
  --python \
  $2blender-benchmark-script-2.0.0/main.py \
  -- \
  --device-type CPU" > "$2"blenderbenchmark.sh