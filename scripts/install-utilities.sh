#!/bin/bash
#
# This will install a utility from the utilities repository
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2029
# shellcheck disable=SC2154
function install_utility() {
  local identity=$1
  local user=$2
  local dns_ip=$3

  echo
  echo "\$identity=$identity"
  echo "\$user=$user"
  echo "\$dns_ip4=$dns_ip"

  echo "Cloning utilities to /tmp"
  rm -rf /tmp/utilities
  cd /tmp
  git clone https://github.com/sty-holdings/utilities
  echo "Copying utilities to server /opt"
  # shellcheck disable=SC2086
  scp -r $identity /tmp/utilities $user@$dns_ip:/opt
}

# Test
install_utility "-i /Users/syacko/.ssh/root-local-0030" root local.sty-holdings.net