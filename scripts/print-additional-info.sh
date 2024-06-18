#!/bin/bash
#
# This will print additional information.
#

set -eo pipefail

# Main function of this script
# shellcheck disable=SC2154
# shellcheck disable=SC2028
function print_additional_info() {
  local name=$1

  case "$name" in
  savup-backend)
    display_info "*** IMPORTANT READ"
    echo "Make sure the NATS and savup-http servers are running."
    echo "Run the 'generate-nats-creds.sh' script on the server, if you haven't already. Update the 'nats-savup-backend.creds and "
    echo "  the AWS SSM savup-$SERVER_ENVIRONMENT-nats-token."
    echo
    echo "The $name flow is the following:"
    echo " 1) Make sure WORKING_AS is set correctly."
    echo " 2) Build the executable using -b"
    echo " 3) Use action -S to scrub $name from the system."
    echo " 4) Create the $name user ($name) with action -U. To change user from $name you have to modify this script."
    echo " 5) Install $name server certificates and certificate key with action -C."
    echo " 6) Install $name server with action -i."
    echo
    echo "Other Steps:"
    echo "  - Start $name server and review the status and journal."
    ;;
  savup-http)
    display_info "*** IMPORTANT READ"
    echo "Make sure the NATS server is running."
    echo "Run the 'generate-nats-creds.sh' script on the server, if you haven't already. Update the 'nats-savup-http.creds and "
    echo "  the AWS SSM savup-$SERVER_ENVIRONMENT-nats-token."
    echo
    echo "The $name flow is the following:"
    echo " 1) Make sure WORKING_AS is set correctly."
    echo " 2) Build the executable using -b"
    echo " 3) Use action -S to scrub $name from the system."
    echo " 4) Create the $name user ($name) with action -U. To change user from $name you have to modify this script."
    echo " 5) Install $name server certificates and certificate key with action -C."
    echo " 6) Install $name server with action -i."
    echo
    echo "Other Steps:"
    echo "  - Start $name server and review the status and journal."
    ;;
  setup-ssh-nats.sh)
    display_info "*** IMPORTANT READ"
    echo " If you are using auto-setup.sh, skip to Other Steps."
    echo
    echo "The flow is the following:"
    echo " 1) Make sure WORKING_AS is set correctly."
    echo " 2) Use action -S to scrub NATS from the system."
    echo " 3) Create the NATS user ($NATS_SYSTEM_USER) with action -U. To change user from $NATS_SYSTEM_USER you have to modify this script."
    echo " 4) Install nats-server, natscli, and nsc with action -i."
    echo " 5) Use action -o or -O to create an operator with sys. O is without signing key requirement."
    echo " 6) Use action -a or -A to create an account. A is without signing key requirement."
    echo " 7) Create and install the resolver.conf file using action -r."
    echo " 8) Now, you need to push (-P) the operator, SYS, and account to the nats server. This step installs the systemd service file."
    echo " 9) Install the nats.conf file that is used by the server. Use action -n or -N."
    echo " 9) If you are using TLS connections (Recommended), run with -C."
    echo "10) Creating a NATS account user with NATS context on the server. Use action -m."
    echo
    echo "Other Steps:"
    echo "  - Run the 'generate-nats-creds.sh' script on the server and update the 'nats-savup-*.creds' files and "
    echo "    the AWS SSM savup-*-nats-token for the $SERVER_ENVIRONMENT environment."
    echo "  - Create local NATS context. User action -x."
    echo "  - Installing certificates and key if you want TLS access only. Use action -C."
    echo "  - Creating a NATS account user with NATS context on the server. Use action -m."
    echo
    ;;
  setup-ssh-instance.sh)
    display_info "*** IMPORTANT READ -- READ, PLEASE READ!!!!!!"
    echo "Edit your alias file to remove shortcuts to instance."
    echo "Edit your .ssh/known-host file to remove ssh keys to instance."
    echo "Remove the file from ~/.ssh for the environment, root, and users."
    echo
    display_info " DID YOU READ THE ABOVE STEPS? "
    echo
    echo "The $name flow is the following:"
    echo " 1) Make sure WORKING_AS is set to 'root'."
    echo " 2) Update the hostname using -n. The system will reboot so the change is enabled."
    echo " 3) Use action -k for the root user to setup ssh identity file access."
    echo " 4) Add an alias to connect to the server for the root user with action -a."
    echo " 5) Create a non-root user with action -U."
    echo " 6) Add the non-root user to the sudo group using action -s, if they should have sudo access.\n   ** -S will add the user with NOPASSWD option. **"
    echo
    echo " ** IMPORTANT **"
    echo " 7) Change the yaml file so WORKING_AS is now the non-root user."
    echo " 8) Use action -k for the non-root user to create the ssh identity file and install it."
    echo " 9) Configure the non-root user using action -c."
    echo " 10) Login with identity file (step 7) and validate user account."
    echo
    echo "Optional Commands:"
    echo " Using action -i you can install tools for the instance. The yaml file must have TOOL_LIST populated."
    ;;

  esac
}
