# IMPORTANT !
# PLEASE READ
# this folder is to create a backend to store statefile (by using s3 , dynamodb table)
# you must & can run only once at first initialization of the project
# or directly create s3 and dynamodb table as required at aws console
# Do Not run again after creation,all statefiles should be stored in exactly one place.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51.0"
      //only allow from 4.51.0 to 4.51.9999999
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

module "tf_backend" {
  source    = "../../modules/tf_backend"
  prefix    = "bkl-syd"
  Project   = "bkl-syd"
  Owner     = "XiaoyuFan"
  ManagedBy = "Terraform"
}



