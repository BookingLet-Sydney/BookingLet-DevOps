#!/bin/bash
set -e
terraform workspace list
terraform workspace select ${workspace}