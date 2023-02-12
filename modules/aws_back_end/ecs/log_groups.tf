resource "aws_cloudwatch_log_group" "example" {
  name              = "/ecs/${var.prefix}-${terraform.workspace}"
  retention_in_days = 30

}

