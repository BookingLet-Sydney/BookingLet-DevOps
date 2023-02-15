#!/bin/bash
set -e
terraform workspace list
echo "heheheheh--${destroy}"
terraform workspace select ${destroy}