SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# app icon setup
cd $SCRIPT_DIR
cp "../assets/nuke.png" "$2/nuke.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="Juno Nuke" --latest_path="juno nuke" --categories="nuke, compositing" --destination="$1" --icon="$1"/nuke.png --terminal="True"
echo "Desktop file created."

cat $2/*.desktop

