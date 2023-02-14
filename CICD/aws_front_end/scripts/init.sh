#!/bin/bash
set -e
terraform init
terraform fmt --recursive