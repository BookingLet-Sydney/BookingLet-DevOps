#!/bin/bash
set -e
echo "****************************************************"
echo "*****************tf destroy*********************"
terraform destroy --auto-approve
rm -rf terraform.tfvars
echo "****************************************************"