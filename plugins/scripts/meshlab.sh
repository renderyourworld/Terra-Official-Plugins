echo "Switching to squashfs-root directory"
cd ROOT_APP/squashfs-root/
echo "Running Meshlab"
junogl $(readlink -f $0) ROOT_APP/squashfs-root/AppRun
