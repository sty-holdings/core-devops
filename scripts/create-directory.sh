#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
    # shellcheck disable=SC2029
    # shellcheck disable=SC2154
function create_directory() {
    local ssh_connection=$1
    local directory_root=$2
    local directory_name=$3
    local owner_user=$4
    local permissions=$5

#    echo
#    echo ssh_connection="$ssh_connection"
#    echo directory_root="$directory_root"
#    echo directory_name="$directory_name"
#    echo owner_user="$owner_user"
#    echo permissions="$permissions"
#    echo

    # shellcheck disable=SC2086
    find_remote_directory "$ssh_connection" $directory_root $directory_name
    if [ "$find_remote_directory_result" == "missing" ]; then
      echo "Creating directory."
      # shellcheck disable=SC2086
      ssh $ssh_connection  "sudo mkdir $directory_root/$directory_name"
    else
      echo "Directories already exist."
    fi
    echo "Setting ownership."
    # shellcheck disable=SC2086
    ssh $ssh_connection  "sudo chown -R $owner_user $directory_root/$directory_name "
    echo "Setting permissions."
    # shellcheck disable=SC2086
    ssh $ssh_connection "sudo chmod -R $permissions $directory_root/$directory_name"
}

# Test
#. find-directory.sh
#create_directories "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" \
#styh \
#"/home/styh" \
#"test-create" \
#"styh-nats" \
#"777"