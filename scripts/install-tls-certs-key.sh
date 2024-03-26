#!/bin/bash
#
# This will create SavUp server directories.
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2154
# shellcheck disable=SC2029
function install_tls_certs_key() {
  local install_directory=$1
  local cert_owner=$2

  validate_server_environment
  if [ "$validate_server_environment_result" == "failed" ]; then
    exit 99
  fi

  are_cert_settings_valid
  if [ "$are_cert_settings_valid_result" == "yes" ]; then
    . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/find-directory.sh
    find_remote_directory "$IDENTITY" $WORKING_AS $INSTANCE_DNS_IPV4 $install_directory .certs
    if [ "$find_remote_directory_result" == "missing" ]; then
      echo "Creating the $install_directory/.certs directory."
      ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "mkdir $install_directory/.certs; sudo chown -R $cert_owner $install_directory/.certs; sudo chmod -R 770 $install_directory/.certs;"
    fi
      echo "Installing certificate, CABundle, and certificate key."
    scp $IDENTITY $CERT_DIRECTORY/$CA_BUNDLE_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:$install_directory/.certs
    scp $IDENTITY $CERT_DIRECTORY/$CERT_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:$install_directory/.certs
    scp $IDENTITY $CERT_DIRECTORY/$CERT_KEY_FILENAME $WORKING_AS@$INSTANCE_DNS_IPV4:$install_directory/.certs
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "chmod -R 640 $install_directory/.certs/*;"
    ssh $IDENTITY $WORKING_AS@$INSTANCE_DNS_IPV4 "sudo chown -R $cert_owner $install_directory/.certs;"
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
