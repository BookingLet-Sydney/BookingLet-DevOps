terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

# resource "aws_vpc" "myvpc_use_internally" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = var.sss
#     Name = var.mylist[1]
#     Name = var.mymap["Key2"]
#   }
# }

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-f"
  }
}

variable "ingress" {
  type    = list(number)
  default = [80, 8000, 443]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.test.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      description      = "test from terrforma"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    }

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "test from terrforma"
  }
}
