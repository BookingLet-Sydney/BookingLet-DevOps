#!/bin/bash
set -e

echo "****************************************************"
echo "****************tf apply***********************"
terraform apply --auto-approve
rm -rf terraform.tfvars
echo "****************************************************"