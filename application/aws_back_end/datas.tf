
data "aws_caller_identity" "current" {}

data "aws_iam_policy" "AmazonEC2ContainerServiceRole" {
  name = "AmazonEC2ContainerServiceRole"
}


data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

