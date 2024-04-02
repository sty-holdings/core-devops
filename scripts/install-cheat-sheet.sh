#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

# Main function of this script
function install_cheat_sheet() {
  identity=$1
  working_as=$2
  server_instance_ipv4=$3
  system_user=$4
  cheat_sheet_name=$5


  # shellcheck disable=SC2086
  find_directory '../cheat-sheet' $cheat_sheet_name.txt
  # shellcheck disable=SC2086
  find_remote_directory "$identity" $working_as $server_instance_ipv4 /home/$system_user docs
  # shellcheck disable=SC2154
  if [ "$find_remote_directory_result" == "found" ]; then
    echo "Installing $cheat_sheet_name cheat sheet."
    # shellcheck disable=SC2086
    scp $identity ../cheat-sheet/$cheat_sheet_name.txt $working_as@$server_instance_ipv4:/home/$system_user/docs/$cheat_sheet_name.txt
  else
    echo "/home/$system_name/docs is missing."
    exit 99
  fi
}

# Test
