echo "Installing pycharm-community-$1"

curl -LJO "https://download.jetbrains.com/python/pycharm-community-$1.tar.gz"
tar xzf pycharm-*.tar.gz -C "$2"
ln -sfv "$2pycharm-community-$1/bin/pycharm.sh" "$2latest"
