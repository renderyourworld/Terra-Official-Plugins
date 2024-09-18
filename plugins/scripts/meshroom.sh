echo "Running Meshroom"
cd ROOT_APP/Meshroom-2023.3.0/Meshroom
echo "Running Meshlab"
junogl $(readlink -f $0) ROOT_APP/Meshroom-2023.3.0/Meshroom
