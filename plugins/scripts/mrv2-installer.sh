echo "Installing $1"

mkdir -p /apps/mrv2

curl -L -O --output-dir /apps/mrv2/ https://github.com/ggarra13/mrv2/releases/download/v1.2.1/mrv2-v1.2.1-Linux-amd64.tar.gz
tar -xvf "/apps/mrv2/mrv2-v1.2.1-Linux-amd64.tar.gz" -C /apps/mrv2

mv /apps/mrv2/mrv2-v1.2.1-Linux-amd64/usr/local/mrv2-v1.1.7-Linux-64 /apps/mrv2/1.2.1
rm -rf /apps/mrv2/mrv2-v1.2.1-Linux-amd64 /apps/mrv2/mrv2-v1.2.1-Linux-amd64.tar.gz
echo "Link: /apps/mrv2/latest -> /apps/mrv2/mrv2"

cp /apps/mrv2/mrv2.png /apps/mrv2/1.2.1/bin/mrv2.png
cp /apps/mrv2/run_mrv2.sh /apps/mrv2/1.2.1/run_mrv2.sh

chmod +x /apps/mrv2/1.2.1/run_mrv2.sh

ln -sfv "/apps/mrv2/1.2.1/bin/run_mrv2.sh" /apps/mrv2/latest
chmod +x /apps/mrv2/latest