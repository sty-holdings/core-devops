#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

# Main function of this script
function install_binary() {
  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SERVER_NAME bin
  if [ "$find_remote_directory_result" == "found" ]; then
    echo "Installing binary."
    scp $IDENTITY $ROOT_DIRECTORY/servers/$SERVER_NAME/bin/$SERVER_NAME $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/bin/$SERVER_NAME
  else
    echo "/home/$SERVER_NAME/bin is missing."
    exit 99
  fi
}
# Test
