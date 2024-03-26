#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
function validate_NATS_account_user() {
  if [ -z "$NATS_ACCOUNT_USER" ]; then
    # shellcheck disable=SC2034
    validate_NATS_account_user_result='failed'
    display_error "The NATS_ACCOUNT_USER must be provided."
  fi
}
