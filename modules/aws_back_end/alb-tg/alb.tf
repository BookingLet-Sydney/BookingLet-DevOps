resource "aws_lb" "test" {
  name               = "${var.prefix}-${terraform.workspace}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnets
  //The subnet for your internet-facing load balancer must have a route to an internet gateway.
  // You can update the subnet’s route table in th
  // no need for vpc_id
  tags = {
    "Name" = "${"var.prefix"}-${"terraform.workspace"}-alb"
  }
}

variable "subnets" {
  type = list(string)

}


