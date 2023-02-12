resource "aws_cloudwatch_metric_alarm" "high" {
  alarm_name          = "${var.prefix}-${terraform.workspace}-cpu>=${var.high_threshold}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  // way to compare
  evaluation_periods = var.evaluation_periods
  // The number of periods over 
  metric_name = var.metric_name
  namespace   = "AWS/ECS"
  period      = var.period
  // seconds

  statistic = var.statistic

  threshold = var.high_threshold

  alarm_description = "This metric monitors ecs-service cpu utilization"
  //insufficient_data_actions = []
  actions_enabled    = "true"
  alarm_actions      = [var.auto_scaling_policy_scaleUp_arn]
  treat_missing_data = "missing"
  # datapoints_to_alarm

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
}

resource "aws_cloudwatch_metric_alarm" "low" {
  alarm_name          = "${var.prefix}-${terraform.workspace}-cpu<${var.low_threshold}"
  comparison_operator = "LessThanOrEqualToThreshold "
  // way to compare
  evaluation_periods = var.evaluation_periods
  // The number of periods over 
  metric_name = var.metric_name
  namespace   = "AWS/ECS"
  period      = var.period
  // seconds

  statistic = var.statistic

  threshold = var.low_threshold

  alarm_description = "This metric monitors ecs-service cpu utilization"
  //insufficient_data_actions = []
  actions_enabled    = "true"
  alarm_actions      = [var.auto_scaling_policy_scaleDown_arn]
  treat_missing_data = "missing"
  # datapoints_to_alarm

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
}
