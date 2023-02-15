#!/bin/bash
set -e
echo "****************************************************"
echo "Pre-install aws-cli and Terraform"
echo "****************************************************"

### aws
sudo apt-get -qq update && sudo apt -qq install python3-pip -y && sudo pip3 install -q awscli --upgrade
echo "****************************************************"
echo "aws --version"
aws --version
echo "****************************************************"


### terraform 
sudo apt -qq update
sudo apt -qq install  software-properties-common gnupg2 curl
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt -qq install terraform

echo "****************************************************"
echo "terraform --version"
terraform --version
echo "****************************************************"