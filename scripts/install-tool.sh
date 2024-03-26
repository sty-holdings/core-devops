#!/bin/bash
#
# Description: This will configure an existing instance using ssh protocols.
#
# Installation:
#   None required
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
#

set -eo pipefail

# Main function of this script
function install_tool {
  tool=$1

  #
  # Tools
  #
  case "$tool" in
  docker)
    # Add a local Alias for the instance and user
    display_info "TOOL: Installing Docker"
    ssh $IDENTITY $WORKING_AS@$SERVER_INSTANCE_IPV4 "sudo apt update; sudo apt install -y apt-transport-https ca-certificates curl software-properties-common; curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg"
    ssh $IDENTITY $WORKING_AS@$SERVER_INSTANCE_IPV4 'echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
    ssh $IDENTITY $WORKING_AS@$SERVER_INSTANCE_IPV4 "sudo apt update; sudo systemctl stop docker; sudo apt install -y docker-ce docker-ce-cli containerd.io; sudo systemctl start docker; sudo systemctl enable docker; sudo docker --version; sudo docker run hello-world; sudo docker compose version"
    display_spacer
    ;;
  nifi)
    # Add a local Alias for the instance and user
    display_info "TOOL: Installing Apache Nifi"
    # shellcheck disable=SC2029
    ssh $IDENTITY $WORKING_AS@$SERVER_INSTANCE_IPV4 "sudo mkdir -p /opt/nifi; sudo chown -R $SYSTEM_USER:$SYSTEM_USER_GROUP /opt/nifi; sudo mkdir -p /opt/dockerfile/nifi;"
    display_spacer
    ;;
  certs)
    # Add a local Alias for the instance and user
    display_info "TOOL: Installing Apache Nifi"
    # shellcheck disable=SC2029
    ssh $IDENTITY $WORKING_AS@$SERVER_INSTANCE_IPV4 "sudo mkdir -p /opt/nifi; sudo chown -R $SYSTEM_USER:$SYSTEM_USER_GROUP /opt/nifi; sudo mkdir -p /opt/dockerfile/nifi;"
    display_spacer
    ;;

  esac
}
