resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "scale-xxx"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "PercentChangeInCapacity"
    //ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity.
    cooldown                = 60
    metric_aggregation_type = "Average"
    //"Minimum", "Maximum", and "Average"

    step_adjustment {
      # start from threshold??? here is 50,so
      # >= 50

      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 20
      scaling_adjustment          = 10
    }

    step_adjustment {
      metric_interval_lower_bound = 20
      metric_interval_upper_bound = 40
      scaling_adjustment          = 20
    }

    step_adjustment {
      metric_interval_lower_bound = 40
      #metric_interval_upper_bound = 50

      scaling_adjustment = 30
    }


    #   Take the action:
    # Add 10 when 50 <= CPUUtilization < 60
    # Add 20 when 60 <= CPUUtilization
  }


}
