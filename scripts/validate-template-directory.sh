#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_template_directory() {
  if [ -z "$TEMPLATE_DIRECTORY" ]; then
    validate_template_directory_result="failed"
    display_error "The TEMPLATE_DIRECTORY must be provided."
  fi
}

