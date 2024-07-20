echo "Installing comfyui $1"

cd "$1"
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
python3 -m venv venv --copies
source venv/bin/activate
pip install uv
echo ""
echo "Installing requirements. This could take a while."
echo ""
uv pip install -r requirements.txt

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR/comfyui.sh" ./
chmod +x ./comfyui.sh

ln -sfv "$1ComfyUI/comfyui.sh" "$1latest"
