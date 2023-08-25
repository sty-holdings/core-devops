#!/bin/bash
#
# This is reusable code for restarting and displaying status of a systemd server
#

function restart_system() {
  if [ -z ${PAUSE} ]; then
    PAUSE=10
  else
    PAUSE=$1
  fi

  display_info "Restarting ${SERVER_NAME} with ${PAUSE} second pause before status is reported."
  if gcloud compute ssh --zone ${GC_REGION} ${GC_REMOTE_LOGIN} --command "sudo systemctl restart ${SERVER_NAME}.service; sleep ${PAUSE}; sudo systemctl status ${SERVER_NAME}.service"; then
    echo
  fi
}

