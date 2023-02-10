module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.prefix}-${terraform.workspace}"
  //name (string)
  //Description: Name to be used on all the resources as identifier
  // this is not a resource-name, it works like a prefix to all resources!
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  single_nat_gateway = true

  enable_dns_hostnames = true

  private_subnet_suffix = "private"
  public_subnet_suffix  = "public"

  tags = {
    # "Name" = "-vpc"
    # BUG : Dont use Name = "name" tag here, it will over write all resources names, no matter what 'name'
    # attribute you define above
    # e.g. name = "vpc"  tags{ "Name" = 'test'}. it will always show 'test'
    # Only in this 'aws/vpc'module,other module is fine.
    # It will automatically assign specific "Name" tags to all individual resources,so don't worry.
  }
 

}

