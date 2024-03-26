#!/bin/bash
#
# Name: build-ca-bundle.sh
#
# Description: This will create the CA bundle file
#
# Required order of the files to be input to the CA Bundle file
# 1) yourdomain.com.crt - Main certificate/Server certificate
# 2) SectionRSADomainValidationSecureServerCA.crt - Intermediate2
# 3) USERTrustRSAAAACA.crt - Intermediate1
# 4) AAACertificateServices.crt - Root certificate
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
CA_NAME=CAbundle.crt

function init_script() {
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-error.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-info.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-possible-failure-note.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-savup-msg.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-spacer.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-warning.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/echo-colors.sh
  . /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/display-skip.sh
  display_info "Script has been initialized."
}

function build_ca_bundle_file() {
  CERT_DIRECTORY=${ROOT_DIRECTORY}/keys/$ENVIRONMENT/.keys/savup/STAR_savup_com
  cat $CERT_DIRECTORY/STAR_savup_com.crt $CERT_DIRECTORY/SectigoRSADomainValidationSecureServerCA.crt $CERT_DIRECTORY/USERTrustRSAAAACA.crt $CERT_DIRECTORY/AAACertificateServices.crt > $CERT_DIRECTORY/$CA_NAME
}

function set_variable() {
  cmd="${1}=$2"
  eval "$cmd"
  cmd="${1}_CHECKED=\"true\""
  eval "$cmd"
}

function validate_parameters() {
  if [ -z "$ENVIRONMENT_CHECKED" ]; then
    local Failed="true"
    display_error "The environment parameter is missing"
  else
    if [ "$ENVIRONMENT" == "dev" ]; then
      ENVIRONMENT="development"
    else
      if [ "$ENVIRONMENT" == "prod" ]; then
        ENVIRONMENT="production"
      else
        if [ "$ENVIRONMENT" == "local" ]; then
          ENVIRONMENT="local"
        else
          local Failed="true"
          display_error "The environment parameter must be either dev or prod"
        fi
      fi
    fi
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
  echo "Usage: ${FILENAME} -h | -e {target environment}"
  echo
  echo "flags:"
  echo "  -h\t\t\t\t\t display help"
  echo "  -e {local|dev|prod}\t Set the target environment where the CA bundle file will be used."
  echo
}

# shellcheck disable=SC2028
function print_parameters() {
  display_info "Here are the values you have supplied:"
  echo "ENVIRONMENT:\t${ENVIRONMENT}"
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

  while getopts 'e:' OPT; do # see print_usage
    case "$OPT" in
    e)
      set_variable ENVIRONMENT "$OPTARG"
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
  build_ca_bundle_file

  display_info "$CA_NAME is located here: $CERT_DIRECTORY"
  display_spacer
  echo Done

}

init_script
run_script "$@"
