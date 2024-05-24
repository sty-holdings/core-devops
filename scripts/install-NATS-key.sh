#!/bin/bash
#
# This will install the NATS credentials file
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2029
# shellcheck disable=SC2154
function install_NATS_key() {
  # shellcheck disable=SC2086
  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SERVER_NAME .keys
  if [ "$find_remote_directory_result" == "missing" ]; then
    echo "Creating /home/$SERVER_NAME/.certs."
    # shellcheck disable=SC2086
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "mkdir /home/$SERVER_NAME/.keys; sudo chown -R $WORKING_AS /home/$SERVER_NAME/.keys; sudo chmod -R 770 /home/$SERVER_NAME/.keys;"
  fi
  echo "Installing NATS credentials/key."
  # shellcheck disable=SC2086
  scp $IDENTITY $KEYS_DIRECTORY/$NATS_KEY_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/.keys
  # shellcheck disable=SC2086
  ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chmod -R 660 /home/$SERVER_NAME/.keys/$NATS_KEY_FILENAME;"
}

# Test
