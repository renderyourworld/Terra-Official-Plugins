echo "Installing $1 to $2"

mrv2_dir=$2
mkdir -p $mrv2_dir

curl -L -O --output-dir $mrv2_dir https://github.com/ggarra13/mrv2/releases/download/v1.2.1/mrv2-v1.2.1-Linux-amd64.tar.gz
tar -xvf "/apps/mrv2/mrv2-v1.2.1-Linux-amd64.tar.gz" -C $mrv2_dir

mv $mrv2_dir/mrv2-v1.2.1-Linux-amd64/usr/local/mrv2-v1.2.1-Linux-64 $mrv2_dir/1.2.1
rm -rf $mrv2_dir/mrv2-v1.2.1-Linux-amd64 $mrv2_dir/mrv2-v1.2.1-Linux-amd64.tar.gz
echo "Link: $mrv2_dir/latest -> $mrv2_dir/mrv2"


#cp /apps/mrv2/run_mrv2.sh /apps/mrv2/1.2.1/run_mrv2.sh
touch $mrv2_dir/1.2.1/run_mrv2.sh
echo "pushd $mrv2_dir/1.2.1/bin
./mrv2.sh" > $mrv2_dir/1.2.1/run_mrv2.sh

chmod +x $mrv2_dir/1.2.1/run_mrv2.sh

ln -sfv "$mrv2_dir/1.2.1/run_mrv2.sh" $mrv2_dir/latest
chmod +x $mrv2_dir/latest