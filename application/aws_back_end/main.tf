provider "aws" {
  region = "ap-southeast-2"
}

//s3 backend
terraform {
  backend "s3" {
    bucket         = "bkl-syd-tf-backend-be-bucket"
    key            = "bkl-syd-be.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "bkl-syd-be-terraform-lock-table"
  }
}


resource "aws_vpc" "myvpc_use_internally" {
  cidr_block = "10.0.0.0/16"

}