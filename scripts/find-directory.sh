#!/bin/bash
#
# This is reusable code for finding a directory
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
function find_directory() {
  local search_directory=$1
  local directory=$2

  # shellcheck disable=SC2086
  if find $search_directory -type d -name "$directory" -print -quit; then
    find_directory_result="found"
  else
    # shellcheck disable=SC2034
    find_directory_result="missing"
  fi
}

# Test
#find_string_in_file  'alias root-local-0030' '/Users/syacko/.oh-my-zsh/custom/cloud-aliases.zsh'
#echo "\$find_string_in_file_result=$find_string_in_file_result"

function find_remote_directory() {
  local ssh_connection=$1
  local search_directory=$2
  local directory=$3
  set find_remote_directory_result

#  echo
#  echo "ssh_connection=$ssh_connection"
#  echo "search_directory=$search_directory"
#  echo "file=$directory"
#  echo

  # shellcheck disable=SC2034
  # shellcheck disable=SC2029
  find_remote_directory_result=$(ssh $ssh_connection "if [ \$(find $search_directory -type d -name $directory -print -quit) ]; then echo 'found'; else echo 'missing'; fi")
}

# Test
#find_remote_directory "-i /Users/syacko/.ssh/styh-local-0030 styh@local.sty-holdings.net" \
#"/home/styh" \
#"test-create"
#echo "find_remote_directory_result=$find_remote_directory_result"