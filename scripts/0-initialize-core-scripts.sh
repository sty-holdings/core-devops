#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

. core-devops/scripts/are-cert-settings-valid.sh
. core-devops/scripts/build-private-public-key.sh
. core-devops/scripts/build-ssh-identity-filename.sh
. core-devops/scripts/build-ssh-identity.sh
. core-devops/scripts/build-ssh-identity.sh
. core-devops/scripts/check-server-running.sh
. core-devops/scripts/clear-journalctl.sh
. core-devops/scripts/create-directories.sh
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
. core-devops/scripts/install-AWS-account-info.sh
. core-devops/scripts/install-AWS-creds.sh
. core-devops/scripts/install-FIREBASE-key-info.sh
. core-devops/scripts/install-GCP-key-info.sh
. core-devops/scripts/install-local-instance-alias.sh
. core-devops/scripts/install-NATS-key.sh
. core-devops/scripts/install-SENDGRID-key-info.sh
. core-devops/scripts/install-binary.sh
. core-devops/scripts/install-public-key.sh
. core-devops/scripts/install-server-conf-file.sh
. core-devops/scripts/install-server-user.sh
. core-devops/scripts/install-systemd-service.sh
. core-devops/scripts/install-tls-certs-key.sh
. core-devops/scripts/install-tools.sh
. core-devops/scripts/print-additional-info.sh
. core-devops/scripts/process-running.sh
. core-devops/scripts/rebuild-ssh-add.sh
. core-devops/scripts/restart-system.sh
. core-devops/scripts/set-variables.sh
. core-devops/scripts/validate-AWS-creds.sh
. core-devops/scripts/validate-NATS-account-user.sh
. core-devops/scripts/validate-NATS-key.sh
. core-devops/scripts/validate-semantic-version.sh
. core-devops/scripts/validate-server-environment.sh
. core-devops/scripts/validate-system-user-parent-group.sh
. core-devops/scripts/validate-template-directory.sh
. core-devops/scripts/validate-working-as-home-directory.sh
. core-devops/scripts/yaml-processing.sh