#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
function check_server_running() {
  local process_name=$1
  local action_if=$2

#  echo
#  echo "\$process_name=$process_name"
#  echo "\$action_if=$action_if"
#  echo

  display_info "Checking to see if $process_name is running."
  # shellcheck disable=SC2086
  process_running "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 $process_name 'journalctl' # Check to see if server is running on remote server
  # shellcheck disable=SC2154
  if [ "$process_running_result" == 'found' ]; then
    if [ "$action_if" == "running" ]; then
      display_error "The $process_name is running on this system!!"
      display_info "On the remote server, execute: 'sudo systemctl stop $process_name then rerun this script."
      exit 99
    fi
    echo "The $process_name is running."
  fi
  if [ "$process_running_result" == 'missing' ]; then
    if [ "$action_if" == "stopped" ]; then
      display_error "The $process_name is NOT running on this system!!"
      display_info "On the remote server, execute: 'sudo systemctl start $process_name then rerun this script."
      exit 99
    fi
    echo "The $process_name is stopped."
  fi
  display_spacer
}
