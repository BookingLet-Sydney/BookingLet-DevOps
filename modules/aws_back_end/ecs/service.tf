resource "aws_ecs_service" "app" {
  name            = "${var.prefix}-${terraform.workspace}-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 3


  force_new_deployment = true

  platform_version = "LATEST"

  deployment_minimum_healthy_percent = 100

  deployment_maximum_percent = 200

  enable_ecs_managed_tags = true

  deployment_controller {
    type = "CODE_DEPLOY"
  }
// Blue and Green Deploy for CODE_DEPLOY, default value ECS for rolling update.

  load_balancer {
    target_group_arn = var.target_group_id
    container_name   =  "${var.prefix}-${terraform.workspace}-container"
    container_port   = var.containerPort
  }


  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.cluster_sg_id]
    assign_public_ip = true
    // does not matter, tasks in private subnets ,do not have IGW, so cant reach them even have public IPs
  }


}
