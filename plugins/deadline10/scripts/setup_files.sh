# this setups configmaps paths for deadline
sed -i "s@DESTINATION@$1@g" ./run_webservice.sh
sed -i "s@TERA_CUSTOMPATH@$2@g" ./run_webservice.sh
sed -i "s@DESTINATION@$1@g" ./deadline10/deadline_env.sh
sed -i "s@TERA_CUSTOMPATH@$2@g" ./deadline10/deadline_env.sh
sed -i "s@DESTINATION@$1@g" ./deadline10/deadline.ini
sed -i "s@DESTINATION@$1@g" ./deadline10/webservice-deadline.ini

# show the changes
cat ./run_webservice.sh
cat ./deadline10/deadline_env.sh
cat ./deadline10/deadline.ini

# copy the files to the destination
cp -v ./run_webservice.sh /mnt/$1/service/run_webservice.sh
cp -v ./deadline10/deadline_env.sh /mnt/$1/service/deadline_env.sh
cp -v ./deadline10/deadline.ini /mnt/$1/client/deadline.ini
