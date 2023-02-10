 #     target_tracking_scaling_policy_configuration {
  #     predefined_metric_specification {
  #       predefined_metric_type = "RDSReaderAverageCPUUtilization"
  #     }

  #     target_value       = 75
  #     scale_in_cooldown  = 300
  #     scale_out_cooldown = 300
  #   }

#   resource "aws_appautoscaling_policy" "example" {
#   name      = "example"
#   policy_type = "TargetTrackingScaling"
#   resource_id = "service/${var.ecs_cluster_name}/${aws_ecs_service.example.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   target_tracking_scaling_policy_configuration {
#     target_value = 75
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }
#   }
# }