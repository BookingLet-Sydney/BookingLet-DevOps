#!/bin/bash
set -e

echo "****************************************************"
echo "****************tf apply***********************"
echo "****************************************************"
terraform apply --auto-approve
rm -rf terraform.tfvars
echo "****************************************************"