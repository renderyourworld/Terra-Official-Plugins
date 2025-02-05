SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# app icon setup
cd $SCRIPT_DIR
cp "../assets/nuke_juno.png" "$1/nuke_juno.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Juno" --version="Nuke" --latest_path="$1"/"juno-pipeline-start.sh"  --categories="nuke, compositing" --destination="$1" --icon="$1"/nuke_juno.png --terminal="True"

# Copy our pipeline start shell script
cp $SCRIPT_DIR/juno-pipeline-start.sh $1/juno-pipeline-start.sh
chmod -R 777 $1

echo "Desktop file created."
