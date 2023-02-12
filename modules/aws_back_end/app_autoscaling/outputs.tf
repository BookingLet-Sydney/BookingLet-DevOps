output "auto_scaling_policy_scaleUp_arn" {
  value = aws_appautoscaling_policy.scale_up.arn
}
output "auto_scaling_policy_scaleDown_arn" {
  value = aws_appautoscaling_policy.scale_down.arn
}



