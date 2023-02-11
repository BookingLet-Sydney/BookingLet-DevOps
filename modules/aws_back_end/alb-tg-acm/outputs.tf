output "target_group_arn" {
  value = aws_lb_target_group.app_ip_target_group.arn
}

output "target_group_name" {
  value = aws_lb_target_group.app_ip_target_group.name
}