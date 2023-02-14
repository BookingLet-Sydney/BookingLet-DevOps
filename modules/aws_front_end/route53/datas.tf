data "aws_route53_zone" "hosted_zone" {
  name = "bookinglet.link"
}
# data "aws_s3_bucket" "www_domain" {
#   bucket = var.www_domain
# }
# data "aws_s3_bucket" "non_www_domain" {
#   bucket = var.non_www_domain
# }
