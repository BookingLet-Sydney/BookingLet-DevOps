resource "aws_lb_target_group" "app_ip_target_group" {
  name_prefix = "bk-${terraform.workspace}"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  # tags = merge(
  #   local.common_tags,
  #   {
  #     "Name"  = "${local.prefix}-tg"
  #   }
  # )
  health_check {
    path                = "/v1/store"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${local.prefix}-tg"
  }
}

# resource "aws_lb_target_group_attachment" "app" {
#   target_group_arn = aws_lb_target_group.app_ip_target_group.arn
#   target_id        = aws_instance.app_ip_target_group.id
#   port             = 80
# }


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
variable "alb_sg_id" {
  type = string

}
