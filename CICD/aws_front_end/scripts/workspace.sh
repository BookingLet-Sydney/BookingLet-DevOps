#!/bin/bash
set -e
terraform workspace list
terraform workspace select ${destroy}