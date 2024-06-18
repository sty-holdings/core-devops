#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
function check_server_running() {
  local process_name=$1
  local action_if=$2
  local exclude_string=$3

#  echo "check"
#  echo "process_name=$process_name"
#  echo "action_if=$action_if"
#  echo "exclude_string=$exclude_string"
#  echo

  display_info "Checking to see if $process_name is running."
#  process_running $process_name 'journalctl' # Check to see if server is running on remote server

  echo "SSH_IDENTITY_FILENAME=$SSH_IDENTITY_FILENAME"
  echo "SSH_SERVER_USER=$SSH_SERVER_USER"
  # shellcheck disable=SC2154
  echo "ssh -i $SSH_IDENTITY_FILENAME $SSH_SERVER_USER 'ps aux > /tmp/processes.tmp'"
  ssh -i $SSH_IDENTITY_FILENAME $SSH_SERVER_USER 'ps aux > /tmp/processes.tmp'

  find_string_excluding_remote_file $process_name $exclude_string "/tmp/processes.tmp"
  echo "find_string_excluding_remote_file=$find_string_excluding_remote_file"

# shellcheck disable=SC2154
#  if [ "$process_running_result" == 'found' ]; then
#    if [ "$action_if" == "running" ]; then
#      display_error "The $process_name is running on this system!!"
#      display_info "On the remote server, execute: 'sudo systemctl stop $process_name then rerun this script."
#      exit 99
#    fi
#    echo "The $process_name is running."
#  fi
#  if [ "$process_running_result" == 'missing' ]; then
#    if [ "$action_if" == "stopped" ]; then
#      display_error "The $process_name is NOT running on this system!!"
#      display_info "On the remote server, execute: 'sudo systemctl start $process_name then rerun this script."
#      exit 99
#    fi
#    echo "The $process_name is stopped."
#  fi
#  display_spacer
}

#Test
. display-error.sh
. display-info.sh
. display-spacer.sh
. process-running.sh
. find-string-in-file.sh
cat  /Users/syacko/.ssh/styh-local-0030
export SSH_IDENTITY_FILENAME="/Users/syacko/.ssh/styh-local-0030"
export SSH_SERVER_USER="styh@local.sty-holdings.net"
check_server_running "nats-server" "running"
check_server_running "jack-fruit" "running"
