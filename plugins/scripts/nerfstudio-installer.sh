echo "Installing NerfStudio..."

export PIP_INDEX_URL=https://pypi.org/simple
export UV_LINK_MODE=copy

# we need to rebuild python
apt update -y &&  apt upgrade -y && apt update -y


uv python install 3.10.12

uv venv $1/venv

echo "Python 3.10.12 installed ?"
python3 --version

echo "Installing NerfStudio PIP deps"
#python3 -m venv venv --copies
source $1/venv/bin/activate
uv pip install --upgrade pip

echo "Install NerfStudio"
uv pip install nerfstudio

echo "Install Gradio"
uv pip install gradio

echo "Clone WebUI install"
cd $1
git clone https://github.com/nerfstudio-project/nerfstudio-webui.git

# app icon setup
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cp "../assets/nerfstudio.png" "$1/nerfstudio.png"
echo "Adding desktop file"
chmod +X create_desktop_file.py
python3 create_desktop_file.py --app_name="nerfstudio" --version="1.1" --latest_path="$1"/nerfstudio.sh --categories="nerfstudio" --destination="$1" --icon="$1$2"/nerfstudio.png --terminal="False"
echo "Desktop file created."
chmod -R 777 "$1/"
cat $1/*.desktop
