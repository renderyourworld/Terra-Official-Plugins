cd ComfyUI
echo "Trying to run Comfy. . . "
sleep 2
echo "Will it work?"
sleep 2
echo "Maybe....."
sleep 1
echo "                .... Lets find out."
echo "Warming up . . . "
export PIP_INDEX_URL=https://pypi.org/simple
echo "Launching ComfyUI"
venv/bin/python ./main.py --listen 0.0.0.0 --disable-xformers --preview-method auto --multi-user
