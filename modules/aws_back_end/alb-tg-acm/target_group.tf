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

resource "aws_lb_target_group" "green_app_ip_target_group" {
  name = "test"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/v1/store"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }

  tags = {
    "Name" = "${local.prefix}-tg"
  }
}

resource "aws_lb_target_group" "app_ip_target_group" {
  name_prefix = "bk-${terraform.workspace}"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

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
