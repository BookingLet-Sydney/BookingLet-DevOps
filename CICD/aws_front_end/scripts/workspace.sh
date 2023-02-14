#!/bin/bash
set -e
terraform workspace list
terraform workspace select ${HOSTED_ZONE_ID}