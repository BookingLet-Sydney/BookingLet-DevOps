module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.prefix}-${terraform.workspace}-vpc"
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}

