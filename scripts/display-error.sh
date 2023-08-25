#!/bin/bash
#
# This is reusable code for displaying a error message
#

# shellcheck disable=SC2129
function display_error() {
  echo "${BLACK}${ON_YELLOW}ERROR: $1${COLOR_OFF}"
}
