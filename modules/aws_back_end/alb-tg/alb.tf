resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnets
  //The subnet for your internet-facing load balancer must have a route to an internet gateway.
  // You can update the subnet’s route table in th
// no need for vpc_id
   tags = {
     "Name" = "test-lb-tf"
   }
}

variable "subnets" {
  type = list(string)

}
