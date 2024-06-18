#!/bin/bash
#
# This will build the ssh connection string
#

set -eo pipefail

# Main function of this script
    # shellcheck disable=SC2029
    # shellcheck disable=SC2154
function build_ssh_connection() {
    local ssh_identity_filename=$1
    local ssh_user=$2
    local ssh_dns_ip=$3

#    echo
#    echo ssh_identity_filename="$ssh_identity_filename"
#    echo ssh_user="$ssh_user"
#    echo ssh_dns_ip="$ssh_dns_ip"
#    echo

   # shellcheck disable=SC2034
   export SSH_CONNECTION="-i $ssh_identity_filename $ssh_user@$ssh_dns_ip"
}

# Test
#build_ssh_connection "/Users/syacko/.ssh/styh-local-0030" \
#styh \
#"local.sty-holdings.net"
#echo "SSH_CONNECTION=$SSH_CONNECTION"