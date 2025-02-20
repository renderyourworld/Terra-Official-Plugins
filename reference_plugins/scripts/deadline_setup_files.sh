# this setups configmaps paths for deadline
echo "                                                                       "
echo "        ===========   =====     ****     ==   ======              =====           =========
         ==========   =====     ****     ===   =======            =====       =================
              =====   =====     ****     =====  =======           =====     =====================
              =====   =====     ****     =====  =========         =====    =======         =======
              =====   =====     ****     =====  ===========       =====   ======              ======
              =====   =====     ****     =====  ===== ======      =====  ======     *****     ======
              =====   =====     ****     =====  =====   ======    =====  =====     *******     =====
              =====   =====     ****     =====  =====    =======  =====  =====     *******     =====
              =====   =====     ****     =====  =====      ====== =====  ======     *****     ======
              =====   ======            ======  =====        ==========   ======             =======
 ====       ======     =======        =======   =====         =========    =======         =======
=================       ====================    =====           =======     =====================
  =============            ==============       =====             =====       =================
                                                                    ===           =========
                                                                     ==                             "
echo "Setting up Deadline 10 environment variables $1 $2"
sed -i "s@DESTINATION@$2@g" $1
sed -i "s@TERA_CUSTOMPATH@$3@g" $1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sed -i "s@DESTINATION@$2@g" $SCRIPT_DIR/deadline10/deadline_env.sh

sed -i "s@TERA_CUSTOMPATH@$3@g" $SCRIPT_DIR/deadline10/deadline_env.sh


sed -i "s@DESTINATION@$2@g" $SCRIPT_DIR/deadline10/deadline.ini
sed -i "s@DESTINATION@$2@g" $SCRIPT_DIR/deadline10/webservice-deadline.ini

# show the changes
cat $1
cat $SCRIPT_DIR/deadline10/deadline_env.sh
cat $SCRIPT_DIR/deadline10/deadline.ini