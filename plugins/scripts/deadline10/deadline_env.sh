# source the env for webservice
echo "Setting up Deadline 10 environment variables"
export TERRA_DEADLINE_PATH=DESTINATION
export DEADLINE_PATH=$TERRA_DEADLINE_PATH/client/bin
export DEADLINE_WEBSERVICE_PATH=$TERRA_DEADLINE_PATH/webservice
export TERRA_DEADLINE_REPOSITORY_PATH=$TERRA_DEADLINE_PATH/repository

# custom variables for Deadline 10 here below
export TERRA_DEADLINE_WEBSERVICE_HOST="http://deadline-server:8081"




