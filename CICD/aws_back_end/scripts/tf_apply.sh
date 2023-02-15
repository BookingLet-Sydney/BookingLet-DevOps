#!/bin/bash
set -e
echo "****************************************************"
terraform apply --auto-approve
rm -rf terraform.tfvars
echo "****************************************************"
