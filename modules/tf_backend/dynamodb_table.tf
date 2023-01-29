locals {
  prefix = "{var.prefix}-{terraform.workspace}"
  common_tags = {
    Project   = var.Project
    Owner     = var.Owner
    ManagedBy = var.ManagedBy
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = "${var.prefix}-terraform-lock-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    local.common_tags,
    { "Name" = "${var.prefix}-terraform-lock-table" }
  )

}
