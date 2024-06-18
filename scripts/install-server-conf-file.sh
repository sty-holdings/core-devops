#!/bin/bash
#
# This will install all the files needed for the SavUp Server
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2154
function install_server_conf_file() {
  local template_filename=$1

  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SERVER_NAME .config
  if [ "$find_remote_directory_result" == "found" ]; then
    echo "Installing configuration file."
    envsubst <$TEMPLATE_DIRECTORY/$template_filename >/tmp/$SERVER_NAME.conf
    scp $IDENTITY /tmp/$SERVER_NAME.conf $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/.config/$SERVER_NAME.conf
  else
    echo "/home/$SERVER_NAME/.config is missing."
    exit 99
  fi
}

# Test
#export IDENTITY="-i /Users/syacko/.ssh/savup-local-0030"
#export WORKING_AS=savup
#export INSTANCE_DNS_IPV4=154.12.225.56
#export NATS_INSTALL_DIRECTORY=/home/NATS
#export ROOT_DIRECTORY=/Users/syacko/workspace/styh-dev/src/albert
#export TEMPLATE_DIRECTORY=$ROOT_DIRECTORY/savup-nats/build-deploy/templates
#install_systemd_service $NATS_INSTALL_DIRECTORY $WORKING_AS $TEMPLATE_DIRECTORY 'nats-server-servicefile.template' 'nats-server.service'
