#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2154
# shellcheck disable=SC2029
function install_tls_certs_key() {
  # shellcheck disable=SC2086
  local identity=$1
  local working_as=$2
  local server_instance_ipv4=$3
  local install_directory=$4
  local tls_ca_bundle_fqn=$5
  local tls_cert_fqn=$6
  local tls_cert_key_fqn=$7
  local cert_owner=$8

  # shellcheck disable=SC2086
  are_cert_settings_valid $tls_ca_bundle_fqn $tls_cert_fqn $tls_cert_key_fqn
  if [ "$are_cert_settings_valid_result" == "yes" ]; then
    . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/find-directory.sh
    # shellcheck disable=SC2086
    find_remote_directory "$identity" $working_as $server_instance_ipv4 $install_directory .certs
    if [ "$find_remote_directory_result" == "missing" ]; then
      echo "Creating the $install_directory/.certs directory."
    # shellcheck disable=SC2086
      ssh $identity $working_as@$server_instance_ipv4 "mkdir $install_directory/.certs; sudo chown -R $cert_owner $install_directory/.certs; sudo chmod -R 770 $install_directory/.certs;"
    fi
      echo "Installing certificate, CABundle, and certificate key."
    # shellcheck disable=SC2086
    scp $identity $tls_ca_bundle_fqn $working_as@$server_instance_ipv4:$install_directory/.certs
    # shellcheck disable=SC2086
    scp $identity $tls_cert_fqn $working_as@$server_instance_ipv4:$install_directory/.certs
    # shellcheck disable=SC2086
    scp $identity $tls_cert_key_fqn $working_as@$server_instance_ipv4:$install_directory/.certs
    # shellcheck disable=SC2086
    ssh $identity $working_as@$server_instance_ipv4 "chmod -R 640 $install_directory/.certs/*;"
    # shellcheck disable=SC2086
    ssh $identity $working_as@$server_instance_ipv4 "sudo chown -R $cert_owner $install_directory/.certs;"
  else
    display_warning "The CERT_DIRECTORY, CA_BUNDLE_FILENAME, CERT_FILENAME, and CERT_KEY_FILENAME are not all set."
  fi
}

# Test
#export IDENTITY="-i /Users/syacko/.ssh/savup-local-0030"
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
