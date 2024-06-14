#!/bin/bash
#
# This is reusable code for logging and execute NATS NSC commands
#
# Copyright (c) 2022 STY-Holdings Inc
# MIT License
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the “Software”), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to
# do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# shellcheck disable=SC2129
function find_string_in_file() {
  local search_string=$1
  local file=$2

#    echo
#    echo search_string=$1
#    echo file=$2
#    echo

  if grep -q "$search_string" "$file"; then
    find_string_in_file_result="found"
  else
    # shellcheck disable=SC2034
    find_string_in_file_result="missing"
  fi
}

# Test
#find_string_in_file  'alias root-local-0030' '/Users/syacko/.oh-my-zsh/custom/cloud-aliases.zsh'
#echo "\$find_string_in_file_result=$find_string_in_file_result"

# shellcheck disable=SC2029
function find_string_in_remote_file() {
  local search_string=$1
  local file=$2
  set find_string_in_remote_file_result

#  echo
#  echo "search_string=$search_string"
#  echo "file=$file"
#  echo

  # shellcheck disable=SC2034
  # shellcheck disable=SC2154
  find_string_in_remote_file_result=$(ssh "$build_ssh_identity_result" "$build_ssh_server_user_result" "grep -q '$search_string' $file && echo 'found' || echo 'missing'")
}

# Test
#find_string_in_remote_file "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" "nats-server" "/tmp/processes.tmp"
#echo "find_string_in_remote_file_result=$find_string_in_remote_file_result"
#find_string_in_remote_file "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" "jack-fruit" "/tmp/processes.tmp"
#echo "find_string_in_remote_file_result=$find_string_in_remote_file_result"

function find_string_excluding_remote_file() {
  local ssh_identity=$1
  local ssh_server_user=$2
  local exclude_string=$3
  local file=$4
  set find_string_excluding_remote_file_result

  echo "string"
  echo "ssh_identity=$ssh_identity"
  echo "ssh_server_user=$ssh_server_user"
  echo "search_string=$search_string"
  echo "exclude_string=$exclude_string"
  echo "file=$file"
  echo

  # shellcheck disable=SC2034
  find_string_excluding_remote_file_result=$(ssh "$ssh_identity" "$ssh_server_user"  "grep -q -E '$search_string | ^$exclude_string' $file && echo 'found' || echo 'missing'")
}

# Test
#find_string_excluding_remote_file "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" "nats-server" "" "/tmp/processes.tmp"
#echo "find_string_excluding_remote_file_result=$find_string_excluding_remote_file_result"
#find_string_excluding_remote_file "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" "jack-fruit" "" "/tmp/processes.tmp"
#echo "find_string_excluding_remote_file_result=$find_string_excluding_remote_file_result"
