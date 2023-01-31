resource "aws_lb_target_group" "ip_target_group" {
  name        = "${local.prefix}-tg"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  tags = merge(
    local.common_tags,
    {
      "Name"  = "${local.prefix}-tg"
    }
  )
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Terraform   = "True"
  }
}

variable "prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}
