module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "${var.prefix}-${terraform.workspace}-cluster"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/${var.prefix}-${terraform.workspace}-cluster"
        // cluster container insight - info e.g. Number of running tasks
      }
    }
  }
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 99
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 1
      }
    }
  }
  tags = {
    "Name" = "${var.prefix}-${terraform.workspace}-cluster"
  }
}

# resource "aws_ecs_cluster_capacity_providers" "app" {
#   cluster_name = module.ecs.cluster_name
#   capacity_providers = [
#     "FARGATE",
#     "FARGATE_SPOT",
#   ]
#    default_capacity_provider_strategy {

#       capacity_provider = "FARGATE"
#       weight = 70
#       base = 0


#       capacity_provider = "FARGATE_SPOT"
#       weight = 30
#       base = 0

#    }
# }
