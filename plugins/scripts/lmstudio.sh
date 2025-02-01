echo "Running LMstudio"
cd ROOT_APP/squashfs-root/
sleep 1
echo "Checking if .lmstudio directory exists"
sleep 1
if [ ! -d "$HOME/.lmstudio" ]; then
  mkdir -p $HOME/.lmstudio
  mkdir -p $HOME/.lmstudio/models
  ln -s ROOT_APP/cache/models $HOME/.lmstudio/models
  echo "Created .lmstudio directory"
  echo "Linked .lmstudio/models directory from apps."
  sleep 1
fi

echo "Setup complete. Running LM-Studio..."
echo "Yea... "
sleep 2
./lm-studio
