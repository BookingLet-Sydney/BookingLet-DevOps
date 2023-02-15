#!/bin/bash
echo 'hhhhhhhhhh'
echo "****************************************************"
terraform workspace list

echo "****************************************************"
terraform workspace select $1
echo "****************************************************"