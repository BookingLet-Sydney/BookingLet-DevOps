
data "aws_caller_identity" "current" {}

data "aws_iam_policy" "AmazonEC2ContainerServiceRole" {
  name = "AmazonEC2ContainerServiceRole"
}


data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}


data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_lb_hosted_zone_id" "app" {}

data "aws_route53_zone" "selected" {
  name         = "bookinglet.link"
  private_zone = false
}
