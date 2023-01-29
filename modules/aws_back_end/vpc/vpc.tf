variable "vpcname" {
  type = string
}
//input

output "vpc_arn" {
  value = aws_vpc.xxx.arn
}
//output


resource "aws_vpc" "xxx" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.vpcname
  }
}
