#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
    # shellcheck disable=SC2029
    # shellcheck disable=SC2154
function create_directories() {

    find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SERVER_NAME bin
    if [ "$find_remote_directory_result" == "missing" ]; then
      echo "Creating directories."
      ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo mkdir /home/$SERVER_NAME/.config/ /home/$SERVER_NAME/.run/ /home/$SERVER_NAME/bin/ /home/$SERVER_NAME/logs/ /home/$SERVER_NAME/scripts/"
    else
      echo "Directories already exist."
    fi
    echo "Setting ownership."
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chown -R $WORKING_AS /home/$SERVER_NAME/.config/ /home/$SERVER_NAME/.run/ /home/$SERVER_NAME/bin/ /home/$SERVER_NAME/logs/ /home/$SERVER_NAME/scripts/"
    echo "Setting permissions."
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chmod -R  770 /home/$SERVER_NAME/.config/ /home/$SERVER_NAME/.run/ /home/$SERVER_NAME/bin/ /home/$SERVER_NAME/logs/ /home/$SERVER_NAME/scripts/"
}

# Test
#export IDENTITY="-i /Users/syacko/.ssh/savup-local-0030"
#export WORKING_AS=savup
#export INSTANCE_DNS_IPV4=154.12.225.56
#export NATS_WEBSOCKET_PORT
#export ROOT_DIRECTORY=/Users/syacko/workspace/styh-dev/src/albert
#export TEMPLATE_DIRECTORY=$ROOT_DIRECTORY/savup-nats/build-deploy/templates
#export NATS_INSTALL_DIRECTORY=/home/NATS
#export CERT_DIRECTORY=$ROOT_DIRECTORY/keys/$SERVER_ENVIRONMENT/.keys/savup/STAR_savup_com
#export CA_BUNDLE_FILENAME=CAbundle.crt
#export CERT_FILENAME=STAR_savup_com.crt
#export CERT_KEY_FILENAME=savup.com.key
#add_tls='false'
#install_NATS_conf $add_tls
#cat /tmp/nats.conf.tmp
#export NATS_WEBSOCKET_PORT=5555
#install_NATS_conf 'false'
#echo "cat /tmp/nats.conf.tmp"
#cat /tmp/nats.conf.tmp
#echo "===================================="
#export NATS_WEBSOCKET_PORT=5555
#install_NATS_conf 'true'
#cat /tmp/nats.conf.tmp
#export NATS_WEBSOCKET_PORT=
#install_NATS_conf 'true'
#cat /tmp/nats.conf.tmp
