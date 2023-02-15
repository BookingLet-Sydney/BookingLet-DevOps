#!/bin/bash
set -e

echo "****************************************************"
terraform workspace list
echo "****************choose workspace to $1 ***************************"
terraform workspace select $1
echo "****************************************************"