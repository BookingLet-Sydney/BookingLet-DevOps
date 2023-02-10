resource "aws_cloudwatch_metric_alarm" "foobar1" {
  alarm_name          = "cpu>= 50"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  // way to compare
  evaluation_periods = "1"
  // The number of periods over 
  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"
  period      = "60"

  statistic = "Average"
  /////
  threshold = "50"
  ///// 50% CPU
  alarm_description = "This metric monitors ec2 cpu utilization"
  //insufficient_data_actions = []
  actions_enabled    = "true"
  alarm_actions      = [var.auto_scaling_policy_arn]
  treat_missing_data = "missing"
  # datapoints_to_alarm

  dimensions = {
    ClusterName = "bkl-syd-app-dev-cluster"
    ServiceName = "test-service"
  }
}

# resource "aws_cloudwatch_metric_alarm" "foobar2" {
#   alarm_name                = "cpu <= 80"
#   comparison_operator       = "LessThanOrEqualToThreshold"
#   // way to compare
#   evaluation_periods        = "1"
#   // The number of periods over 
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/ECS"
#   period                    = "60"
#   statistic                 = "Average"
#   threshold                 = "80"
#   alarm_description         = "This metric monitors ec2 cpu utilization"
#   //insufficient_data_actions = []
#     alarm_enabled       = true
#   alarm_actions  = [var.auto_scaling_policy_arn]
#   treat_missing_data = "missing"
# }

variable "auto_scaling_policy_arn" {
  type = string

}
