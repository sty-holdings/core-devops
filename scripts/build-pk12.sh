#!/bin/bash
#
# Name: build-pk12.sh
#
# Description: This will create a pk12 file of the server crt
#
# Installation:
#   None required
#
# Copyright (c) 2022 STY-Holdings Inc
# All Rights Reserved

set -eo pipefail

# script variables
FILENAME=$(basename "$0")
#
# User Controlled variables that should be reviewed and edited if needed.
ROOT_DIRECTORY=/Users/syacko/workspace/styh-dev/src/albert
CERT_DIRECTORY=${ROOT_DIRECTORY}/keys/'MISSING'/.keys/savup/STAR_savup_com
PK12_FILENAME=""
PK12_PASSWORD=""

function init_script() {
  #  Core
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/init-core-scripts.sh
  #
  . /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/init-shared-scripts.sh
  display_spacer
  display_spacer
  display_info "Script has been initialized."
}


function build_pk12_file() {
  CERT_DIRECTORY=${ROOT_DIRECTORY}/keys/$SERVER_ENVIRONMENT/.keys/savup/STAR_savup_com
  openssl pkcs12 -in $CERT_DIRECTORY/STAR_savup_com.crt -nokeys -passout pass:$PK12_PASSWORD -export -out /Users/syacko/workspace/styh-dev/src/albert/keys/production/.keys/savup/pk12/$PK12_FILENAME
}

function set_variable() {
  cmd="${1}=$2"
  eval "$cmd"
  cmd="${1}_CHECKED=\"true\""
  eval "$cmd"
}

function validate_parameters() {
  if [ -z "$PK12_FILENAME" ]; then
    local Failed="true"
    display_error "The Pk12 filename parameter is missing"
  fi
  if [ -z "$PK12_PASSWORD" ]; then
    local Failed="true"
    display_error "The Pk12 password parameter is missing"
  fi
  validate_server_environment
  if [ "$validate_server_environment_result" == "failed" ]; then
    exit 99
  fi

  if [ "$Failed" == "true" ]; then
    print_usage
    exit 1
  fi
}

# shellcheck disable=SC2028
function print_parameters() {
  display_info "Here are the values you have supplied:"
  display_spacer
}

# shellcheck disable=SC2028
function print_usage() {
  display_info "This will create a CA Bundle file."
  echo
  echo "Usage: ${FILENAME} -h | -e {target server environment}"
  echo
  echo "flags:"
  echo "  -h\t\t\t\t\t display help"
  echo "  -e {local|development|production}\t Set the target server environment where the pk12 file will be used."
  echo "  -f {PK12 filename}"
  echo "  -p {PK12 password}"
  echo
}

# shellcheck disable=SC2028
function print_parameters() {
  display_info "Here are the values you have supplied:"
  echo "SERVER_ENVIRONMENT:\t${SERVER_ENVIRONMENT}"
  echo "PK12_FILENAME:\t${PK12_FILENAME}"
  echo "PK12_PASSWORD:\t${PK12_PASSWORD}"
  echo
  echo "Here are the pre-set or defined variables:"
  echo "ROOT_DIRECTORY:   ${ROOT_DIRECTORY}"
  echo "CERT_DIRECTORY: ${CERT_DIRECTORY}"
  echo "CA_NAME:\t ${CA_NAME}"

  display_spacer
}

# Main function of this script
function run_script {
  if [ "$#" == "0" ]; then
    display_error "No parameters where provided."
    print_usage
    exit 1
  fi

  while getopts 'e:f:p:' OPT; do # see print_usage
    case "$OPT" in
    e)
      set_variable SERVER_ENVIRONMENT "$OPTARG"
      ;;
    f)
      set_variable PK12_FILENAME "$OPTARG"
      ;;
    p)
      set_variable PK12_PASSWORD "$OPTARG"
      ;;
    h)
      print_usage
      exit 0
      ;;
    *)
      display_error "Please review the usage printed below:" >&2
      print_usage
      exit 1
      ;;
    esac
  done

  validate_parameters
  print_parameters
  build_pk12_file

  display_info "$PK12_FILENAME is located here: $CERT_DIRECTORY"
  display_spacer
  echo Done

}

init_script
run_script "$@"
