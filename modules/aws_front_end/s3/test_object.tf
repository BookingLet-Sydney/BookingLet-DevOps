#Upload the file
resource "aws_s3_bucket_object" "object" {
  bucket       = aws_s3_bucket.www_domain.bucket
  key          = "index.html"
  source       = "${path.module}/website/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/website/index.html")
}