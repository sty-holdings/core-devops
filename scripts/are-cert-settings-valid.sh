#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function are_cert_settings_valid() {
  ca_bundle_fqn=$1
  cert_fqn=$2
  cert_key_fqn=$3

#  echo "\$ca_bundle_fqn=$1"
#  echo "\$cert_fqn=$2"
#  echo "\$cert_key_fqn=$3"

  if [ -z "$ca_bundle_fqn" ] || [ -z "$cert_fqn" ] || [ -z "$cert_key_fqn" ]; then
    are_cert_settings_valid_result='no'
  else
    are_cert_settings_valid_result='yes'
  fi
}
