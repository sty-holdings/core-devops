#!/bin/bash
#
# This will install all the files needed for a SavUp Server
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2154
    # shellcheck disable=SC2029
function install_AWS_account_info() {
  local template_filename=$1

  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 /home/$SERVER_NAME .config
  if [ "$find_remote_directory_result" == "missing" ]; then
    echo "Creating /home/$SERVER_NAME/.config."
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "mkdir /home/$SERVER_NAME/.config; sudo chown -R $WORKING_AS /home/$SERVER_NAME/.config; sudo chmod -R  770 /home/$SERVER_NAME/.config/"
  fi
  echo "Installing AWS account info file."
  envsubst <$TEMPLATE_DIRECTORY/$template_filename >/tmp/AWS-account-info.tmp
  scp $IDENTITY /tmp/AWS-account-info.tmp $WORKING_AS@$INSTANCE_DNS_IPV4:/home/$SERVER_NAME/.config/$AWS_ACCOUNT_INFO_FILENAME
  ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chmod -R 660 /home/$SERVER_NAME/.config/$AWS_ACCOUNT_INFO_FILENAME;"
}

# Test
