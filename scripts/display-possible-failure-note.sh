#!/bin/bash
#
# This is reusable code for outputting a possible failure note on the screen
#

function display_possible_failure_note() {
  echo "NOTE: If any of the $1 commands fail on the remote instance, this script will continue to execute. You will have investigate if the error is critical."
}

