module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "${var.prefix}-${terraform.workspace}-cluster"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/${var.prefix}-${terraform.workspace}-cluster"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = {
   "Name" = "${var.prefix}-${terraform.workspace}-cluster"
  }
}

variable "prefix" {
    type =  string
  
}