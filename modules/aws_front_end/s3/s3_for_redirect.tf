resource "aws_s3_bucket" "non_www_domain" {
  bucket = var.non_www_domain
}

resource "aws_s3_bucket_acl" "non_www_domain" {
  bucket = aws_s3_bucket.non_www_domain.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "non_www_domain" {
  bucket = aws_s3_bucket.non_www_domain.bucket

  redirect_all_requests_to {
    host_name = var.www_domain
  }
}

