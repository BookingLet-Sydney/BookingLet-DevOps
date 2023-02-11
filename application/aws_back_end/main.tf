provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Terraform   = "True"
    }
  }
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
  prefix             = "bkl-syd-app"
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = true
  enable_vpn_gateway = false
  # single_nat_gateway= true
  azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  // the private_subnets No. should always be the times of public_subnets, e.g. 3-3 6-3
  // the number of azs should be equal to the number of public subnets
}

module "ecr" {
  source                            = "../../modules/aws_back_end/ecr"
  prefix                            = "bkl-syd-app"
  repository_read_write_access_arns = length(var.repository_read_write_access_arns) == 0 ? [data.aws_caller_identity.current.arn] : var.repository_read_write_access_arns

}

module "security_group" {
  source                = "../../modules/aws_back_end/security_group"
  vpc_id                = module.vpc.vpc_id
  prefix                = "bkl-syd-app"
  alb_inbound_ports     = [80, 443]
  cluster_inbound_ports = [8000]
}

module "alb-tg-acm" {
  source    = "../../modules/aws_back_end/alb-tg-acm"
  vpc_id    = module.vpc.vpc_id
  prefix    = "bkl-syd-app"
  alb_sg_id = module.security_group.alb_sg_id
  subnets   = module.vpc.public_subnets
}

module "ecs" {
  source             = "../../modules/aws_back_end/ecs"
  prefix             = "bkl-syd-app"
  image_uri          = "820599146567.dkr.ecr.ap-southeast-2.amazonaws.com/bookinglet-sydney-app:latest"
  task_role_arn      = module.role.ecs_execution_task_role_arn
  execution_role_arn = module.role.ecs_execution_task_role_arn
  env_s3_arn         = "arn:aws:s3:::bkl-app-dev-env-s3"
  containerPort      = 8000
  target_group_id    = module.alb-tg-acm.target_group_arn
  cluster_sg_id      = module.security_group.cluster_sg_id
  private_subnets    = module.vpc.private_subnets
  //private_subnets
  depends_on = [module.role]

}



module "role" {
  source     = "../../modules/aws_back_end/role"
  prefix     = "bkl-syd-app"
  env_s3_arn = "arn:aws:s3:::bkl-app-dev-env-s3"

}

module "grafana" {
  source = "../../modules/aws_back_end/amg"
}

module "cloudwatch" {
  source = "../../modules/aws_back_end/cloudwatch"
  auto_scaling_policy_arn =module.auto_scaling.auto_scaling_policy_arn
}


module "auto_scaling" {
  source = "../../modules/aws_back_end/app_autoscaling"
  depends_on = [module.ecs]
  
}



data "aws_lb_hosted_zone_id" "app" {}

output "zone_id_for_alb" {
  value = data.aws_lb_hosted_zone_id.app.id
}


data "aws_route53_zone" "selected" {
  name         = "bookinglet.link"
  private_zone = false
}

output "host_zone_id_for_bookinglet" {
  value = data.aws_route53_zone.selected.zone_id
}
