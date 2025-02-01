echo "Installing NerfStudio..."

export PIP_INDEX_URL=https://pypi.org/simple
export UV_LINK_MODE=copy

# we need to rebuild python
apt update -y &&  apt upgrade -y && apt update -y
apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

curl https://pyenv.run | bash
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

cd "$1"
pyenv install 3.10.12
pyenv global 3.10.12
echo "Python 3.10.12 installed ?"
python3 --version

echo "Installing NerfStudio PIP deps"
python3 -m venv venv --copies
source $1/venv/bin/activate

uv pip install --upgrade pip
uv pip install torch==2.1.2+cu118 torchvision==0.16.2+cu118 --extra-index-url https://download.pytorch.org/whl/cu118
uv pip install nvidia-cuda-nvcc

uv pip install ninja git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

echo "Install NerfStudio"
uv pip install nerfstudio
uv pip install -e .[dev]
uv pip install -e .[docs]

uv pip install gradio

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
