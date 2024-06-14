#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
function check_server_running() {
  local ssh_connection=$1
  local process_name=$2
  local action_if=$3

#  echo
#  echo "ssh_connection=$ssh_connection"
#  echo "process_name=$process_name"
#  echo "action_if=$action_if"
#  echo

  display_info "Checking to see if $process_name is running."
  process_running "$ssh_connection" $process_name 'journalctl' # Check to see if server is running on remote server
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

#Test
#. display-error.sh
#. display-info.sh
#. display-spacer.sh
#. process-running.sh
#. find-string-in-file.sh
#check_server_running "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" "nats-server" "running"
#check_server_running "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" "jack-fruit" "running"
