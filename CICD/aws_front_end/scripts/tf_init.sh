#!/bin/bash
set -e
echo "****************************************************"
echo "**********terraform init and fmt ***********************"
terraform init
terraform fmt --recursive
echo "****************************************************"