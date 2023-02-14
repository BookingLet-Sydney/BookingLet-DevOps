resource "aws_s3_bucket" "www_domain" {
  bucket = var.www_domain
  #BUG: if you keep the name as
  # "s3-website-test.hashicorp.com"
  #it will lead AccessDenied: Access Denied , so weird!

}

resource "aws_s3_bucket_acl" "www_domain" {
  bucket = aws_s3_bucket.www_domain.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "www_domain" {
  bucket = aws_s3_bucket.www_domain.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_versioning" "www_domain" {
  bucket = aws_s3_bucket.www_domain.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "www_domain" {
  bucket = aws_s3_bucket.www_domain.id
  policy = templatefile("${path.module}/s3-policy.tftpl", {
    s3_bucket_name = var.www_domain

  })
}


output "www_bucket_regional_domain_name" {
  value = aws_s3_bucket.www_domain.bucket_regional_domain_name
  
}


output "non_www_bucket_regional_domain_name" {
  value = aws_s3_bucket.non_www_domain.bucket_regional_domain_name
}