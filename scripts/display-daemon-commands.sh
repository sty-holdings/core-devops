#!/bin/bash
#
# This is reusable code for displaying common systemd commands
#

function display_daemon_commands() {
  echo
  display_spacer
  echo "Daemon Commands:"
  echo "-  sudo systemctl status ${SERVER_NAME}.service"
  echo "-  sudo systemctl start ${SERVER_NAME}.service"
  echo "-  sudo systemctl stop ${SERVER_NAME}.service"
  echo "-  sudo systemctl restart ${SERVER_NAME}.service"
  echo "-  sudo journalctl -u ${SERVER_NAME}.service -n 50"
  echo
}
