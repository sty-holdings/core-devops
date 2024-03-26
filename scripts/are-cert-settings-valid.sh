#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function are_cert_settings_valid() {

#  echo "\$CERT_DIRECTORY=$CERT_DIRECTORY"
#  echo "\$CA_BUNDLE_FILENAME=$CA_BUNDLE_FILENAME"
#  echo "\$CERT_FILENAME=$CERT_FILENAME"
#  echo "\$CERT_KEY_FILENAME=$CERT_KEY_FILENAME"

  if [ -z "$CERT_DIRECTORY" ] || [ -z "$CA_BUNDLE_FILENAME" ] || [ -z "$CERT_FILENAME" ] || [ -z "$CERT_KEY_FILENAME" ]; then
    are_cert_settings_valid_result='no'
  else
    are_cert_settings_valid_result='yes'
  fi
}
