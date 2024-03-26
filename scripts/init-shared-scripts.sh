#!/bin/bash
#
# This will install the SavUp Server binary.
#

set -eo pipefail

. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/are-cert-settings-valid.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/check-server-running.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/create-directories.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-AWS-account-info.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-AWS-creds.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-binary.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-FIREBASE-key-info.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-GCP-key-info.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-NATS-key.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-server-conf-file.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-SENDGRID-key-info.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/install-tls-certs-key.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/print-additional-info.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/validate-AWS-creds.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/validate-NATS-key.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/validate-server-environment.sh
. /Users/syacko/workspace/styh-dev/src/albert/shared/scripts/validate-system-user-parent-group.sh
