terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51.0"
      //only allow from 4.51.0 to 4.51.9999999
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

//s3 backend
terraform {
  backend "s3" {
    bucket         = "bkl-syd-tf-backend-bucket"
    key            = "bkl-syd.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "bkl-syd-terraform-lock-table"
  }
}

# resource "aws_vpc" "myvpc_use_internally" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = var.sss
#     Name = var.mylist[1]
#     Name = var.mymap["Key2"]
#   }
# }

# resource "aws_vpc" "test" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "test-f"
#   }
# }

# variable "ingress" {
#   type    = list(number)
#   default = [80, 8000, 443]
# }

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.test.id

#   dynamic "ingress" {
#     iterator = port
#     for_each = var.ingress
#     content {
#       description      = "test from terrforma"
#       from_port        = port.value
#       to_port          = port.value
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]

#     }

#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "test from terrforma"
#   }
# }

# module "vpc" {
#   source  = "../../modules/aws_back_end/vpc"
#   vpcname = "hahahawocaonmaa"
// input for module
//the vpcname is just varibles found in vpc folder
# }

// output for module 
// --> module.moduleName.outputName
# output "test" {
#   value = module.vpc.vpc_arn
# }

//datasource

# data "aws_instance" "ec2name" {
#   filter {
#     name  = "tag:Name"
#     value = ["DB Sever"]
#   }

# }

# data "aws_ec2_instance_type" "example" {
#   instance_type = "t2.micro"
# }

# output "outputec2id" {
#   value = data.aws_ec2_instance_type.example.default_vcpus

# }

# //local
// locals is kind of dynmaic varibles ,for example var.xxx + var.xxx
// allows you link varibles together from different resources, you can not do that in varibles.tf


# locals {
#   prefix = "${var.prefix} - ${terraform.workspace}"
#   common_tags = {
#     environment = terraform.workspace
#     project = var.prefix
#     owner = var.contact
#     ManagedBy = "terraform"
#   }
# }

resource "aws_vpc" "myvpc_use_internally" {
  cidr_block = "10.0.0.0/16"

  # tags = {
  #   Name = "${local.prefix}--test"
  #   #Name = "${var.prefix}-${terraform.workspace}-test"
  # }

  # tags = merge(
  #   local.common_tags,
  #   map("Name","${var.prefix}-${terraform.workspace}-test")

  # )

}

//dynamic 

//count

//backend

# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/keyxxx.tfstate"
#     region = "us-east-1"
#     encrypt = true
#     dynamodb_table = "sssapp-devops-tf-state-lock"
#   }
# }


//tfvars 

//workspaces
