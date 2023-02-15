#!/bin/bash
set -e
echo "****************************************************"
terraform destroy --auto-approve
rm -rf terraform.tfvars
echo "****************************************************"