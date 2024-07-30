echo "Installing Meshroom $1 - $2"
mkdir -p $2
chmod 777 $1
chmod -R 777 $2
file $1
cat $1
tar xf $1 -C $2