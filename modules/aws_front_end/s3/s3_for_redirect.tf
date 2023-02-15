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
    # host_name = "https://${var.www_domain}"
     host_name = var.www_domain
  }
}

resource "aws_s3_bucket_policy" "non_www_domain" {
  bucket = aws_s3_bucket.non_www_domain.id
  policy = templatefile("${path.module}/s3-policy.tftpl", {
    s3_bucket_name = var.non_www_domain
  })
}

output "non_www_domain_website_endpoint" {
  value = aws_s3_bucket_website_configuration.non_www_domain.website_endpoint
  
}

output "www_domain_website_endpoint" {
  value = aws_s3_bucket_website_configuration.www_domain.website_endpoint
  
}