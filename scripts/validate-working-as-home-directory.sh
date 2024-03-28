#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_working_as_home_directory() {
  if [ -z "$WORKING_AS_HOME_DIRECTORY" ]; then
    validate_working_as_home_directory_result="failed"
    display_error "The working as home directory (FQN) must be provided."
  fi
}

