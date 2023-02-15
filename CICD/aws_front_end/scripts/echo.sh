#!/bin/bash
set -e
echo "test"
### aws
apt-get update && apt install python3-pip -y && pip3 install awscli --upgrade
aws --version


### terraform 
sudo apt update
sudo apt install  software-properties-common gnupg2 curl
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg

sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt install terraform
terraform --version