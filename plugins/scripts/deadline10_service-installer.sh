echo "Setting up Deadline 10 Services"

# check mono
mono --version

mkdir -p /apps/deadline10/service
chmod -R 777 /apps/deadline10/service
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp -v "$SCRIPT_DIR"/deadline.ini /apps/deadline10/service/deadline.ini
mkdir -p /root/Thinkbox
mkdir -p /root/Thinkbox/Deadline10
cp -v "$SCRIPT_DIR"/deadline.ini /root/Thinkbox/Deadline10/deadline.ini
mkdir -p /var/lib/Thinkbox/
mkdir -p /var/lib/Thinkbox/Deadline10
cp -v "$SCRIPT_DIR"/deadline.ini /var/lib/Thinkbox/Deadline10/deadline.ini