resource "aws_s3_bucket" "bucket" {
  bucket = "${var.prefix}-tf-backend-bucket"

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
    { "Name" = "${var.prefix}-tf-backend-bucket" }
  )
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}