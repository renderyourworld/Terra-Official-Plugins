# NukeSamurai Installer Script
# requires python3.10
# requires git

apt install python3.10 git -y

echo "Installing NukeSamurai to /apps/nuke_samurai"
export BUILDER=/tmp/nuke_samurai
mkdir -p $BUILDER

# git clone the NukeSamurai repo
cd $BUILDER
git clone https://github.com/Theo-SAMINADIN-td/NukeSamurai.git
cd $BUILDER/NukeSamurai

python3.10 -m venv $BUILDER/NukeSamurai/venv
source $BUILDER/NukeSamurai/venv/bin/activate

# pull pip deps
pip install torch==2.3.1+cu118 torchvision==0.18.1 --extra-index-url https://download.pytorch.org/whl/cu118
cd $BUILDER/NukeSamurai/sam2_repo
pip install -e .
pip install -e ".[notebooks]"
pip install matplotlib==3.7 tikzplotlib jpeg4py opencv-python lmdb pandas scipy loguru ninja

# download checkpoints
cd checkpoints && \
./download_ckpts.sh && \
cd ..

mv $BUILDER/NukeSamurai $1
echo "NukeSamurai installed to $1"


