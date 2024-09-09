echo "Deadline 10 env setup ..."

# copy ini files
mkdir -p /var/lib/Thinkbox/
mkdir -p /var/log/Thinkbox/
mkdir -p /var/lib/Thinkbox/Deadline10
mkdir -p /var/log/Thinkbox/Deadline10

chmod 777 -Rv /var/log/Thinkbox/Deadline10
chmod 777 -Rv /var/lib/Thinkbox/Deadline10

# FORCE COPY
/bin/cp -f -v DESTINATION/client/deadline.ini /var/lib/Thinkbox/Deadline10/deadline.ini

export DEADLINE_PATH=DESTINATION/client/bin
export PATH=$DEADLINE_PATH:$PATH