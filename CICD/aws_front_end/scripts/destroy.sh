#!/bin/bash
set -e
terraform destroy --auto-approve
rm -rf terraform.tfvars