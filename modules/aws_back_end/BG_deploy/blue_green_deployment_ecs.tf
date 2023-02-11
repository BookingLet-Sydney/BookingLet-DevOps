resource "aws_codedeploy_app" "app" {
  compute_platform = "ECS"
  name = "bkl-syd-dev-Codedeploy"
}

resource "aws_sns_topic" "app" {
  name = "bkl-syd-dev-Codedeploy"
}


resource "aws_codedeploy_deployment_group" "example" {
  app_name               = aws_codedeploy_app.app.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "syd-app-dev-Codedeploy"
  service_role_arn       = aws_iam_role.code_deploy_ecs_role.arn

  auto_rollback_configuration {
    enabled = false
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = "bkl-syd-app-dev-cluster"
    service_name = "test-service"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = var.prod_traffic_listener_arn
      }

      target_group {
        name = var.blue_tg_name
      }

      target_group {
        name = var.green_tg_name
      }
    }
  }
}