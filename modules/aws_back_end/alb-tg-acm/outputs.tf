output "target_group_Blue_arn" {
  value = aws_lb_target_group.app_ip_target_group_Blue.arn
}

output "target_group_Blue_name" {
  value = aws_lb_target_group.app_ip_target_group_Blue.name
}

output "target_group_Green_arn" {
  value = aws_lb_target_group.app_ip_target_group_Green.arn
}

output "target_group_Green_name" {
  value = aws_lb_target_group.app_ip_target_group_Green.name
}

output "aws_lb_listener_app_arn" {
  value = aws_lb_listener.app.arn
}