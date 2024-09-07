SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p "$1"
echo "Installing Template files..."
cp -R "$SCRIPT_DIR/create_templates" "$1/"
chmod -R 777 "$1/"