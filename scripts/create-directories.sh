#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
    # shellcheck disable=SC2029
    # shellcheck disable=SC2154
function create_directories() {
    local identity=$1
    local ssh_user=$2
    local dns_ipv4=$3
    local system_user=$4
    export install_directory=$5 # This is a local variable, but envsubst only works with environment variable, so it must be exported.
    export service_user_name=$6 # This is a local variable, but envsubst only works with environment variable, so it must be exported.

#    echo
#    echo identity=$identity
#    echo ssh_user=$ssh_user
#    echo dns_ipv4=$dns_ipv4
#    echo server_name=$server_name
#    echo install_directory=$install_directory
#    echo service_user_name=$service_user_name
#    echo

    # shellcheck disable=SC2086
    find_remote_directory "$identity" $ssh_user $dns_ipv4 /home/$system_user bin
    if [ "$find_remote_directory_result" == "missing" ]; then
      echo "Creating directories."
      # shellcheck disable=SC2086
      ssh $identity $ssh_user@$dns_ipv4 "sudo mkdir /home/$system_user/.config/ /home/$system_user/.run/ /home/$system_user/bin/ /home/$system_user/logs/ /home/$system_user/scripts/"
    else
      echo "Directories already exist."
    fi
    echo "Setting ownership."
    # shellcheck disable=SC2086
    ssh $identity $ssh_user@$dns_ipv4 "sudo chown -R $ssh_user /home/$system_user/.config/ /home/$system_user/.run/ /home/$system_user/bin/ /home/$system_user/logs/ /home/$system_user/scripts/"
    echo "Setting permissions."
    # shellcheck disable=SC2086
    ssh $identity $ssh_user@$dns_ipv4 "sudo chmod -R  770 /home/$system_user/.config/ /home/$system_user/.run/ /home/$system_user/bin/ /home/$system_user/logs/ /home/$system_user/scripts/"
}

# Test
#export identity="-i /Users/syacko/.ssh/savup-local-0030"
#export WORKING_AS=savup
#export INSTANCE_DNS_IPV4=154.12.225.56
#export NATS_WEBSOCKET_PORT
#export ROOT_DIRECTORY=/Users/syacko/workspace/styh-dev/src/albert
#export TEMPLATE_DIRECTORY=$ROOT_DIRECTORY/savup-nats/build-deploy/templates
#export NATS_INSTALL_DIRECTORY=/home/NATS
#export CERT_DIRECTORY=$ROOT_DIRECTORY/keys/$SERVER_ENVIRONMENT/.keys/savup/STAR_savup_com
#export CA_BUNDLE_FILENAME=CAbundle.crt
#export CERT_FILENAME=STAR_savup_com.crt
#export CERT_KEY_FILENAME=savup.com.key
#add_tls='false'
#install_NATS_conf $add_tls
#cat /tmp/nats.conf.tmp
#export NATS_WEBSOCKET_PORT=5555
#install_NATS_conf 'false'
#echo "cat /tmp/nats.conf.tmp"
#cat /tmp/nats.conf.tmp
#echo "===================================="
#export NATS_WEBSOCKET_PORT=5555
#install_NATS_conf 'true'
#cat /tmp/nats.conf.tmp
#export NATS_WEBSOCKET_PORT=
#install_NATS_conf 'true'
#cat /tmp/nats.conf.tmp
