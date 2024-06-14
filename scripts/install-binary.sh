#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

# Main function of this script
function install_binary() {
  local ssh_identity=$1
  local ssh_server_user=$2
  local system_user=$3
  local binary_path=$4
  local binary_name=$5

#  echo
#  echo ssh_identity="$ssh_identity"
#  echo ssh_server_user="$ssh_server_user"
#  echo system_user="$system_user"
#  echo binary_path="$binary_path"
#  echo binary_name="$binary_name"
#  echo

  find_remote_directory "$ssh_identity $ssh_server_user" /home/$system_user bin
  # shellcheck disable=SC2154
  if [ "$find_remote_directory_result" == "found" ]; then
    echo "Installing binary."
    # shellcheck disable=SC2086
    scp $ssh_identity $binary_path/$binary_name $ssh_server_user:/home/$system_user/bin/$binary_name
  else
    echo "/home/$SERVER_NAME/bin is missing."
    exit 99
  fi
}

#test
#. find-directory.sh
#install_binary "-i /Users/syacko/.ssh/styh-local-0030" "styh@local.sty-holdings.net" "styh-connect" "." install-binary.sh



