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
  single_nat_gateway = true
  azs                = length(var.azs) == 0 ? data.aws_availability_zones.available.names : var.azs
  // the number of azs should be equal to the number of public subnets
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  // the private_subnets No. should always be the times of public_subnets, e.g. 3-3 6-3

}

module "security_group" {
  source                = "../../modules/aws_back_end/security_group"
  vpc_id                = module.vpc.vpc_id
  prefix                = "bkl-syd-app"
  alb_inbound_ports     = [80, 443]
  cluster_inbound_ports = [8000, 8081]
}

module "alb-tg-acm" {
  source    = "../../modules/aws_back_end/alb-tg-acm"
  vpc_id    = module.vpc.vpc_id
  prefix    = "bkl-syd-app"
  alb_sg_id = module.security_group.alb_sg_id
  subnets   = module.vpc.public_subnets

  route53_zone_id = "Z03030356MARD7N1HBSL"
  domain_name     = "bookinglet.link" // it will apply for "api.[domain_name]"
}

module "ecr" {
  source                            = "../../modules/aws_back_end/ecr"
  prefix                            = "bkl-syd-app"
  repository_read_write_access_arns = length(var.repository_read_write_access_arns) == 0 ? [data.aws_caller_identity.current.arn] : var.repository_read_write_access_arns
  // if there is no speficifc iam user for ecr, the current user for terraform should have permission to do so.
}


module "role" {
  source     = "../../modules/aws_back_end/role"
  prefix     = "bkl-syd-app"
  env_s3_arn = "arn:aws:s3:::bkl-app-dev-env-s3"

}


module "ecs" {
  source             = "../../modules/aws_back_end/ecs"
  prefix             = "bkl-syd-app"
  image_uri          = "820599146567.dkr.ecr.ap-southeast-2.amazonaws.com/bookinglet-sydney-app:latest"
  task_role_arn      = module.role.ecs_execution_task_role_arn
  execution_role_arn = module.role.ecs_execution_task_role_arn
  env_s3_arn         = "arn:aws:s3:::bkl-app-dev-env-s3"
  containerPort      = 8000
  memoryReservation  = 400
  // soft memory limit, usually 300-500 for web apps.
  target_group_id = module.alb-tg-acm.target_group_Blue_arn
  cluster_sg_id   = module.security_group.cluster_sg_id
  private_subnets = module.vpc.private_subnets
  //deploy on private_subnets needs a NAT Gateway

}



module "grafana" {
  source = "../../modules/aws_back_end/amg"
  prefix = "bkl-syd-app"
}


//This cloudwatch module is for building CPU Utilization Metrics to trigger App Auto Scaling
module "cloudwatch" {
  source                            = "../../modules/aws_back_end/cloudwatch"
  prefix                            = "bkl-syd-app"
  high_threshold                    = "70"
  low_threshold                     = "30"
  cluster_name                      = module.ecs.cluster_name
  service_name                      = module.ecs.service_name
  evaluation_periods                = "1"
  period                            = "60"
  metric_name                       = "CPUUtilization"
  statistic                         = "Average"
  auto_scaling_policy_scaleUp_arn   = module.auto_scaling.auto_scaling_policy_scaleUp_arn
  auto_scaling_policy_scaleDown_arn = module.auto_scaling.auto_scaling_policy_scaleDown_arn
}


module "auto_scaling" {
  source       = "../../modules/aws_back_end/app_autoscaling"
  resource_id  = "service/${module.ecs.cluster_name}/${module.ecs.service_name}"
  max_capacity = 10
  min_capacity = 1
}

module "BG_deploy" {
  source                    = "../../modules/aws_back_end/BG_deploy"
  prefix                    = "bkl-syd-app"
  depends_on                = [module.ecs]
  cluster_name              = module.ecs.cluster_name
  service_name              = module.ecs.service_name
  prod_traffic_listener_arn = [module.alb-tg-acm.aws_lb_listener_app_arn]
  blue_tg_name              = module.alb-tg-acm.target_group_Blue_name
  green_tg_name             = module.alb-tg-acm.target_group_Green_name
}






