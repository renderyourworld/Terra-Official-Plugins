echo "Downloading Alab sample files"

mkdir -p /apps/alab
cd /apps/alab
git clone https://github.com/DigitalProductionExampleLibrary/ALab.git

echo "Alab sample files downloaded"
echo "Downloading Alab techvars files"
wget -q -O /tmp/techvars.zip https://dpel-assets.aswf.io/usd-alab/alab-techvars.v2.2.0.zip
echo "Downloading Alab textures files"
wget -q -O /tmp/textures.zip https://aswf-dpel-assets.s3.amazonaws.com/usd-alab/alab-textures.v2.2.0.zip
echo "Downloading Alab cameras files"
wget -q -O /tmp/cameras.zip https://dpel-assets.aswf.io/usd-alab/alab-cameras.v2.2.0.zip
echo "Downloading Alab procedurals files"
wget -q -O /tmp/procedurals.zip https://dpel-assets.aswf.io/usd-alab/alab-procedurals.v2.2.0.zip
echo "Downloaded extra sample files"
echo "Extracting Alab sample files"
unzip /tmp/techvars.zip -d /apps/alab/ALab > /dev/null
unzip /tmp/textures.zip -d /apps/alab/ALab > /dev/null
unzip /tmp/cameras.zip -d /apps/alab/ALab > /dev/null
unzip /tmp/procedurals.zip -d /apps/alab/ALab > /dev/null
echo "Extracted extra sample files"

chmod -R 777 /apps/alab
chmod -R 777 /apps/alab/ALab

