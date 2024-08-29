echo "Creating app: $1 from app template"
cd template/templateapp
cp templateapp.py ../../plugins/$1.py
sed -i "s/templateapp/$1/g" ../../plugins/$1.py
cp templateapp-installer.sh ../../plugins/scripts/$1-installer.sh
sed -i "s/templateapp/$1/g" ../../plugins/scripts/$1-installer.sh
cp templateapp.sh ../../plugins/scripts/$1.sh
sed -i "s/templateapp/$1/g" ../../plugins/scripts/$1.sh
cp test_templateapp.py ../../tests/test_$1.py
sed -i "s/templateapp/$1/g" ../../tests/test_$1.py

echo "App $1 created and seeded with templateapp files"