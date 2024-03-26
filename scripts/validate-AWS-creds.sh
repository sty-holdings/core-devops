#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_AWS_creds() {
  if [ -z "$KEYS_DIRECTORY" ] || [ -z "$AWS_CREDS_FILENAME" ]; then
    validate_AWS_creds_result="failed"
    display_error "The KEYS_DIRECTORY and AWS_CREDS_FILENAME must be provided."
  fi
}

