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


module "vpc" {
  source             = "../../modules/aws_back_end/vpc"
  prefix             = "bkl-syd-be"
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = false
  enable_vpn_gateway = false
  azs                = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  // the private_subnets No. should always be the times of public_subnets, e.g. 3-3 6-3
  // the number of azs should be equal to the number of public subnets
}

module "ecr" {
  source                            = "../../modules/aws_back_end/ecr"
  prefix                            = "bkl-syd-be"
  repository_read_write_access_arns = length(var.repository_read_write_access_arns) == 0 ? [data.aws_caller_identity.current.arn] : var.repository_read_write_access_arns

}
