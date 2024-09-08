echo "Deadline 10 env setup ..."

# copy ini files
mkdir -p /var/lib/Thinkbox/
mkdir -p /var/lib/Thinkbox/Deadline10
cp -v DESTINATION/client/deadline.ini /var/lib/Thinkbox/Deadline10/deadline.ini

export DEADLINE_PATH=DESTINATION/client/bin