// link the auto-scaling target to a service

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity = var.max_capacity
  min_capacity = var.min_capacity
  #   resource_id        = "service/clusterName/serviceName"
  resource_id        = var.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

