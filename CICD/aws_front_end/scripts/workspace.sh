#!/bin/bash
set -e
terraform workspace list
terraform workspace select ${params.workspace}