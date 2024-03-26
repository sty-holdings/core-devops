#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_NATS_key() {
  if [ -z "$KEYS_DIRECTORY" ] || [ -z "$NATS_KEY_FILENAME" ]; then
    validate_NATS_key_result="failed"
    display_error "The KEYS_DIRECTORY and NATS_KEY_FILENAME must be provided."
  fi
}

