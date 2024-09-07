echo "Setting up templates"
mkdir -p "$HOME/Templates"
rsync -a /apps/templates  "$HOME/Templates" > /dev/null