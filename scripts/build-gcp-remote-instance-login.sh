#!/bin/bash
#
# This is reusable code for building the GCP login string
#

function build_remote_instance_login() {
  GC_REMOTE_LOGIN=${GC_USER_ACCOUNT}@${GC_INSTANCE_NAME}
}

