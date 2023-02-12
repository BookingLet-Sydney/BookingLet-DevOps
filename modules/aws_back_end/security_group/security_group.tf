locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Terraform   = "true"
  }
}


resource "aws_security_group" "alb_sg" {
  name        = "${local.prefix}-${terraform.workspace}-alb-sg"
  description = "${local.prefix}-${terraform.workspace}-alb-sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.alb_inbound_ports
    content {
      description      = "Inbound Port${port.value}-Terraform"
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

  # tags = merge(
  #   local.common_tags,
  #   {
  #     "Name" = "${local.prefix}-alb-sg"
  #   }
  # )
  tags = {
    "Name" = "${local.prefix}-${terraform.workspace}-alb-sg"
  }
}

resource "aws_security_group" "cluster_sg" {
  name        = "${local.prefix}-${terraform.workspace}-cluster-sg"
  description = "${local.prefix}-${terraform.workspace}-cluster-sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.cluster_inbound_ports
    content {
      description     = "Inbound Port${port.value}-Terraform"
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = ["aws_security_group.alb_sg.id"]

    }

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # tags = merge(
  #   local.common_tags,
  #   {
  #     "Name" = "${local.prefix}-cluster-sg"
  #   }

  # )
  tags = {
    "Name" = "${local.prefix}-${terraform.workspace}-cluster-sg"
  }
}
