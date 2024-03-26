#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

. core-devops/scripts/build-private-public-key.sh
. core-devops/scripts/build-ssh-identity.sh
. core-devops/scripts/build-ssh-identity-filename.sh
. core-devops/scripts/clear-journalctl.sh
. core-devops/scripts/display-alert-msg.sh
. core-devops/scripts/display-daemon-commands.sh
. core-devops/scripts/display-error.sh
. core-devops/scripts/display-info.sh
. core-devops/scripts/display-possible-failure-note.sh
. core-devops/scripts/display-skip.sh
. core-devops/scripts/display-spacer.sh
. core-devops/scripts/display-warning.sh
. core-devops/scripts/echo-colors.sh
. core-devops/scripts/execute-command.sh
. core-devops/scripts/find-directory.sh
. core-devops/scripts/find-file.sh
. core-devops/scripts/find-string-in-file.sh
. core-devops/scripts/get-now-formatted.sh
. core-devops/scripts/install-public-key.sh
. core-devops/scripts/install-server-user.sh
. core-devops/scripts/install-systemd-service.sh
. core-devops/scripts/process-running.sh
. core-devops/scripts/restart-system.sh
. core-devops/scripts/set-variables.sh
. core-devops/scripts/validate-semantic-version.sh
. core-devops/scripts/yaml-processing.sh
