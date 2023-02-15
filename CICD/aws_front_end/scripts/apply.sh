#!/bin/bash
set -e
terraform apply --auto-approve
rm -rf terraform.tfvars