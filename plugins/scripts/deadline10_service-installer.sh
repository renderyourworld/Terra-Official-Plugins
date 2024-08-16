echo "Setting up Deadline 10 Services"

mkdir -p /apps/deadline10/service
chmod -R 777 /apps/deadline10/service
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR"/deadline.ini /apps/deadline10/service/deadline.ini