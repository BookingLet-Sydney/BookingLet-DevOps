terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51.0"
      //only allow from 4.51.0 to 4.51.9999999
    }
  }
}