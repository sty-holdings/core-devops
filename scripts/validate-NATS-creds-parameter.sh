#!/bin/bash
#
# This will check the variable is set
# Validate NATS Key is located here because it is used in more than one script.
#

set -eo pipefail

# shellcheck disable=SC2034
function validate_NATS_creds_parameter() {
  local nats_creds_fqn=$1
  set validate_NATS_creds_parameter_result

#  echo
#  echo "nats_creds_fqn=$nats_creds_fqn"
#  echo

  validate_NATS_creds_parameter_result="passed"

  if [ -z "$nats_creds_fqn" ]; then
    validate_NATS_creds_parameter_result="failed"
  fi
}

#validate_NATS_creds_parameter
#echo "validate_NATS_creds_parameter_result=$validate_NATS_creds_parameter_result"

