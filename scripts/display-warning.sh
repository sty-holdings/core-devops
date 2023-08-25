#!/bin/bash
#
# This is reusable code for displaying a warning message
#

# shellcheck disable=SC2129
function display_warning() {
  echo "${BLACK}${ON_WHITE}WARNING:$1 ${COLOR_OFF}"
}

