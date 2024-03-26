#!/bin/bash
#
# This will install all the files needed for a SavUp Server
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2154
# shellcheck disable=SC2029
function install_SENDGRID_key_info() {

  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SERVER_NAME .keys
  if [ "$find_remote_directory_result" == "missing" ]; then
    echo "Creating /home/$SERVER_NAME/.keys."
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "mkdir /home/$SERVER_NAME/.keys; sudo chown -R $WORKING_AS /home/$SERVER_NAME/.keys; sudo chmod -R 770 /home/$SERVER_NAME/.keys;"
  fi
  echo "Installing Sendgrid key info file."
  scp $IDENTITY $KEYS_DIRECTORY/$SENDGRID_KEY_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/.keys
  ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chmod -R 660 /home/$SERVER_NAME/.keys/$SENDGRID_KEY_FILENAME;"
}

# Test
