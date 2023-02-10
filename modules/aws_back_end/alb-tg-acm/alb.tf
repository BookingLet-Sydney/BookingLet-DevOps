resource "aws_lb" "app" {
  name               = "${var.prefix}-${terraform.workspace}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnets
  //The subnet for your internet-facing load balancer must have a route to an internet gateway.
  // You can update the subnet’s route table 
  // no need for vpc_id

  tags = {
    "Name" = "${var.prefix}-${terraform.workspace}-alb"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy       = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = module.acm.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_ip_target_group.arn
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http-https" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

variable "subnets" {
  type = list(string)

}



