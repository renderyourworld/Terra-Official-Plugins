echo "Installing LDPK to $2"
wget -q -O /tmp/ldpk.tgz "$1"
chmod +x /tmp/ldpk.tgz

cd /tmp
mkdir -p $2
mkdir p /tmp/ldpk_install
tar zxvf /tmp/ldpk.tgz -C /tmp/ldpk_install

ls -la /tmp/ldpk_install


mv /tmp/ldpk_install/ldpk-*/* $2

chmod -R 777 $2
echo "LDPK installed."



