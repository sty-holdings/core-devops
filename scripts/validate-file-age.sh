#!/bin/bash
#
# This will check the variable is set
#
set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_file_age() {
  local ageinminutes=$1
  local filename=$2

  # shellcheck disable=SC2086
  if find "$filename" -mmin +$ageinminutes -print | grep -q '.'; then
      validate_AWS_creds_result="old"
  else
      validate_AWS_creds_result="new"
  fi

}

#Test
#touch /tmp/testfile.tmp
#validate_file_age 5 /tmp/testfile.tmp
#echo $validate_AWS_creds_result
#validate_file_age 5 /tmp/com.avast.antitrack.Shuffler.err
#echo $validate_AWS_creds_result