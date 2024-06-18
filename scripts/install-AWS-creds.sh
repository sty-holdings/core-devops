#!/bin/bash
#
# This will install all the files needed for the SavUp Server
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2029
# shellcheck disable=SC2154
function install_AWS_creds() {

  find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 $WORKING_AS_HOME_DIRECTORY .aws
  if [ "$find_remote_directory_result" == "missing" ]; then
    echo "Creating $WORKING_AS_HOME_DIRECTORY/.aws."
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "mkdir $WORKING_AS_HOME_DIRECTORY/.aws; sudo chown -R $WORKING_AS $WORKING_AS_HOME_DIRECTORY/.aws; sudo chmod -R 775 $WORKING_AS_HOME_DIRECTORY/.aws;"
  fi
  echo "Installing AWS credentials/key."
  scp $IDENTITY $KEYS_DIRECTORY/$AWS_CREDS_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:$WORKING_AS_HOME_DIRECTORY/.aws/credentials
  ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chmod -R 660 $WORKING_AS_HOME_DIRECTORY/.aws/credentials;"
}

# Test
