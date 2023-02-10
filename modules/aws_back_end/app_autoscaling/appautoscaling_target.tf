resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 12
  min_capacity       = 1
#   resource_id        = "service/clusterName/serviceName"
  resource_id        = "service/bkl-syd-app-dev-cluster/test-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

// link the target to a service

output "auto_scaling_policy_arn" {
  value = aws_appautoscaling_policy.ecs_policy.arn
}


# output "scale_up_policy_arn" {
#   value = aws_appautoscaling_policy.ecs_policy.arn
# }

# output "scale_down_policy_arn" {
#   value = aws_appautoscaling_policy.ecs_policy.arn
# }
