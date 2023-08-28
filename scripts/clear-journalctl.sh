#!/bin/bash
#
# This is reusable code for clearing the systemmd journal.
#
# NOTE: --unit according to the documentation should only clear the journal for that unit. My experience is that it clears all. YMMV.
#

function clear_journalctl() {
  display_info "Clearing journalctl for ${SERVER_NAME}"
  display_spacer
  if gcloud compute ssh --zone ${GC_REGION} ${GC_REMOTE_LOGIN} --command " sudo journalctl --flush --rotate --unit=${SERVER_NAME}.service --vacuum-time=1s "; then
    echo
  fi
}

