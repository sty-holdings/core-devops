#!/bin/bash
#
# This will install a utility from the utilities repository
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2029
# shellcheck disable=SC2154
function install_utility() {
  echo
  echo "\$IDENTITY=$IDENTITY"
  echo "\$WORKING_AS=$WORKING_AS"
  echo "\$INSTANCE_DNS_IPV4=$INSTANCE_DNS_IPV4"
  echo "\$SYSTEM_USER=$SYSTEM_USER"

  # shellcheck disable=SC2086
  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SYSTEM_USER bin
  if [ "$find_remote_directory_result" == "missing" ]; then
    echo "Creating /home/$SYSTEM_USER/bin."
    # shellcheck disable=SC2086
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "mkdir /home/$SYSTEM_USER/bin; sudo chown -R $WORKING_AS /home/$SYSTEM_USER/bin; sudo chmod -R 770 /home/$SYSTEM_USER/bin;"
  fi
    # shellcheck disable=SC2086
  scp $IDENTITY $KEYS_DIRECTORY/$NATS_KEY_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/.keys
    # shellcheck disable=SC2086
  ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chmod -R 660 /home/$SERVER_NAME/.keys/$NATS_KEY_FILENAME;"
}

# Test
