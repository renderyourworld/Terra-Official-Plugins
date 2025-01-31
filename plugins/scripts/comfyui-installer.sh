echo "Installing ComfyUI to $1"

export PIP_INDEX_URL=https://pypi.org/simple

cd "$1"
git clone https://github.com/comfyanonymous/ComfyUI.git
git config --global --add safe.directory $1/ComfyUI

cd ComfyUI
python3 -m venv venv
source venv/bin/activate
pip install uv
echo ""
echo "Installing requirements. This could take a while."
echo ""
uv pip install -i https://pypi.org/simple -r requirements.txt

# add manager
cd $1/ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager
git config --global --add safe.directory $1/ComfyUI/custom_nodes/ComfyUI-Manager
cd ComfyUI-Manager
uv pip install -i https://pypi.org/simple -r requirements.txt
# edit config from the comfy manager
#sed -i "s@normal@weak@g" "$1/ComfyUI/user/default/ComfyUI-Manager/config.ini"

cp
# app icon setup
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cp "comfyui.sh" "$1/run_comfyui.sh"
cp "../assets/comfyui.png" "$2/comfyui.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="ComfyUI" --version="1.3" --latest_path="$1"/run_comfyui.sh --categories="comfyui, ai" --destination="$1" --icon="$1"/comfyui.png
echo "Desktop file created."
chmod -R 777 "$1/"



