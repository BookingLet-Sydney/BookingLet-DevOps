#!/bin/bash
set -e
terraform workspace list
echo "heheheheh--${workspace}"
terraform workspace select ${workspace}