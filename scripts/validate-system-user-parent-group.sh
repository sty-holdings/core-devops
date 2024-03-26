#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_system_user_parent_group() {
  if [ -z "$SYSTEM_USER_PARENT_GROUP" ]; then
    validate_system_user_parent_group_result="failed"
    display_error "The SYSTEM_USER_PARENT_GROUP must be provided."
  fi
}


