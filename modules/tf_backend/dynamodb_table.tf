locals {
  prefix = "{var.prefix}-{terraform.workspace}"
  common_tags = {
    Project   = var.Project
    Owner     = var.Owner
    ManagedBy = var.ManagedBy
  }
}

#front_end
resource "aws_dynamodb_table" "terraform-lock-fe" {
  name           = "${var.prefix}-fe-terraform-lock-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    local.common_tags,
    { "Name" = "${var.prefix}-fe-terraform-lock-table" }
  )
}

#back_end
resource "aws_dynamodb_table" "terraform-lock-be" {
  name           = "${var.prefix}-be-terraform-lock-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    local.common_tags,
    { "Name" = "${var.prefix}-be-terraform-lock-table" }
  )
}
