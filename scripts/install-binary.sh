#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

# Main function of this script
function install_binary() {
  local identity=$1
  local binary_root=$2
  local ssh_server_user=$3
  local owner_user=$4
  local permissions=$5

#  echo
#  echo ssh_connection="$ssh_connection"
#  echo directory_root="$directory_root"
#  echo directory_name="$directory_name"
#  echo owner_user="$owner_user"
#  echo permissions="$permissions"
#  echo

  find_remote_directory "$ssh_connection" /home/$SERVER_NAME bin
  # shellcheck disable=SC2154
  if [ "$find_remote_directory_result" == "found" ]; then
    echo "Installing binary."
    # shellcheck disable=SC2086
    scp $IDENTITY $ROOT_DIRECTORY/servers/$SERVER_NAME/bin/$SERVER_NAME $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/bin/$SERVER_NAME
  else
    echo "/home/$SERVER_NAME/bin is missing."
    exit 99
  fi
}


