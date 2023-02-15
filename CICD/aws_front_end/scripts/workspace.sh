#!/bin/bash
set -e
terraform workspace list
echo ${workspace}
terraform workspace select ${workspace}