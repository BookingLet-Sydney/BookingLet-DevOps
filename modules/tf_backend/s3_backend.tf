###############
# front_end
###############
resource "aws_s3_bucket" "fe-bucket" {
  bucket = "${var.prefix}-tf-backend-fe-bucket"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }

  tags = merge(
    local.common_tags,
    { "Name" = "${var.prefix}-tf-backend-fe-bucket" }
  )
}

resource "aws_s3_bucket_versioning" "fe-example" {
  bucket = aws_s3_bucket.fe-bucket.bucket

  versioning_configuration {
    status = "Enabled"
    # varible version(map) [Enabled] = " "
    #status = var.versioning[enabled] == true ? "Enabled" : "Disabled"
  }
}
resource "aws_s3_bucket_public_access_block" "fe-example" {
  bucket = aws_s3_bucket.fe-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

###############
# back_end
###############
resource "aws_s3_bucket" "be-bucket" {
  bucket = "${var.prefix}-tf-backend-be-bucket"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }

  tags = merge(
    local.common_tags,
    { "Name" = "${var.prefix}-tf-backend-be-bucket" }
  )
}

resource "aws_s3_bucket_versioning" "be-example" {
  bucket = aws_s3_bucket.be-bucket.bucket

  versioning_configuration {
    status = "Enabled"
    # varible version(map) [Enabled] = " "
    #status = var.versioning[enabled] == true ? "Enabled" : "Disabled"
  }
}
resource "aws_s3_bucket_public_access_block" "be-example" {
  bucket = aws_s3_bucket.be-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
