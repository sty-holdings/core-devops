#!/bin/bash
#
# This will build the ssh connection string
#

set -eo pipefail

# Main function of this script
    # shellcheck disable=SC2029
    # shellcheck disable=SC2154
function build_ssh_server_user() {
    local ssh_user=$1
    local ssh_dns_ip=$2
    set build_ssh_server_user_result

#    echo
#    echo ssh_user="$ssh_user"
#    echo ssh_dns_ip="$ssh_dns_ip"
#    echo

   # shellcheck disable=SC2034
   export build_ssh_server_user_result="$ssh_user@$ssh_dns_ip"
}

# Test
#build_ssh_server_user styh \
#"local.sty-holdings.net"
#echo "build_ssh_server_user_result=$build_ssh_server_user_result"