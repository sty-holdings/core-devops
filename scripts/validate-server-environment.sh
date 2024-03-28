#!/bin/bash
#
# This will check the variable is set
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2034
function validate_server_environment() {
  validate_server_environment_result="passes"

  case "$SERVER_ENVIRONMENT" in
  local)
    ;;
  development)
    ;;
  production)
    ;;
  *)
    validate_server_environment_result='failed'
    display_error "The SERVER_ENVIRONMENT must be provided and be local, development, or production."
    ;;
  esac
}

#Test
#. /Users/syacko/workspace/styh-dev/src/albert/core/devops/scripts/init-core-scripts.sh
#export SERVER_ENVIRONMENT=""
#validate_server_environment
#echo "validate_server_environment_result=$validate_server_environment_result"
#export SERVER_ENVIRONMENT="local"
#validate_server_environment
#echo "validate_server_environment_result=$validate_server_environment_result"
#export SERVER_ENVIRONMENT="development"
#validate_server_environment
#echo "validate_server_environment_result=$validate_server_environment_result"
#export SERVER_ENVIRONMENT="production"
#validate_server_environment
#echo "validate_server_environment_result=$validate_server_environment_result"
