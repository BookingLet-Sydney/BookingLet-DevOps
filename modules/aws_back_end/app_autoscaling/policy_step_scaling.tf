resource "aws_appautoscaling_policy" "scale_up" {
  name               = "CPU_scale_up"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "PercentChangeInCapacity"
    //ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity.
    cooldown = 60
    # I think it should be larger than the evaluation periods x period time. or it is pointless.
    #https://github.com/awsdocs/application-auto-scaling-user-guide/blob/master/doc_source/application-auto-scaling-step-scaling-policies.md
    metric_aggregation_type = "Average"
    //"Minimum", "Maximum", and "Average"
    # CloudWatch aggregates metric data points based on the statistic 
    # for the metric associated with your CloudWatch alarm. 
    # When the alarm is breached, the appropriate scaling policy is triggered. 
    # Application Auto Scaling applies your specified aggregation type 
    # to the most recent metric data points from CloudWatch 
    # (as opposed to the raw metric data). 
    # It compares this aggregated metric value against the upper and lower bounds defined 
    # by the step adjustments to determine which step adjustment to perform.

    step_adjustment {
      # start from threshold here is >= 50 50,so
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 10
      scaling_adjustment          = 10
    }

    step_adjustment {
      metric_interval_lower_bound = 10
      metric_interval_upper_bound = 20
      scaling_adjustment          = 15
    }

    step_adjustment {
      metric_interval_lower_bound = 20
      #metric_interval_upper_bound = +infinity

      scaling_adjustment = 30
    }
    #   Take the action:
    # Add 10% when 50 <= CPUUtilization < 60
    # Add 20% when 60 <= CPUUtilization < 70
    # Add 30% when 70 <= CPUUtilization 
  }
}


resource "aws_appautoscaling_policy" "scale_down" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "PercentChangeInCapacity"
    cooldown = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      # <= 30
      metric_interval_lower_bound = -5
      metric_interval_upper_bound = 0
      scaling_adjustment          = -5
    }

    step_adjustment {
      metric_interval_lower_bound = -10
      metric_interval_upper_bound = -5
      scaling_adjustment          = -8
    }

    step_adjustment {
      metric_interval_upper_bound = -10
      scaling_adjustment = -10
    }
  }
      #   Take the action:
    # Cut 5% when 25 <= CPUUtilization < 30
    # Cut 8% when 20 <= CPUUtilization < 25
    # Cut 10% CPUUtilization <= 20
}
