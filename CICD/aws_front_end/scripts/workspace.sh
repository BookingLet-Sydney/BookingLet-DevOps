#!/bin/bash
set -e
terraform workspace list
echo "heheheheh--$1"
terraform workspace select ${destroy}