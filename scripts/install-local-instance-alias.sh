#!/bin/bash
#
# Description: This will append aliases to the alias file
#
# Installation:
#   None required
#
# Copyright (c) 2022 STY-Holdings Inc
# All Rights Reserved
#

set -eo pipefail

# Main function of this script
function install_local_instance_alias() {
  local search_string=$1
  local file=$2
  local ssh_user=$3

#    echo "\$search_string=$search_string"
#    echo "\$file=$file"
#    echo "\$ssh_user=$ssh_user"

  echo "Setting up alias to connect to remote server."
  # shellcheck disable=SC2086
  find_string_in_file "$search_string" $file
  #  echo
  #  echo "\$find_string_in_file_result=$find_string_in_file_result"
  #  echo
  # shellcheck disable=SC2154
  if [ "$find_string_in_file_result" == "missing" ]; then
    echo "alias $ssh_user-$SERVER_ENVIRONMENT-$INSTANCE_NUMBER='ssh $IDENTITY $ssh_user@$SERVER_INSTANCE_IPV4'" >>$file
  fi
}

# Test
#. /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/init-core-scripts.sh
#export ALIAS_FQN='/Users/syacko/.oh-my-zsh/custom/cloud-aliases.zsh'
#export INSTANCE_NUMBER='0030'
#export ENVIRONMENT_ALIAS='lcl'
#export SERVER_INSTANCE_IPV4=savup-local-0030.savup.com
#export SYSTEM_USER=savup
#export WORKING_AS="root"
#export IDENTITY="-i /Users/syacko/.ssh/$SYSTEM_USER-$ENVIRONMENT_ALIAS-$INSTANCE_NUMBER"
#install_local_instance_alias $WORKING_AS-$SERVER_ENVIRONMENT-$INSTANCE_NUMBER $ALIAS_FILENAME $WORKING_AS
#install_local_instance_alias "alias $SYSTEM_USER-$ENVIRONMENT_ALIAS-$INSTANCE_NUMBER" $ALIAS_FQN $SYSTEM_USER
