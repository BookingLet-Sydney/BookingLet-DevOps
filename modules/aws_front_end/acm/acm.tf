# CloudFront supports US East (N. Virginia) Region only.
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"

  providers = {
    aws = aws.us-east-1
  }

  domain_name = var.www_domain
  subject_alternative_names = [
    var.non_www_domain
  ]
  zone_id = data.aws_route53_zone.hosted_zone.id

  wait_for_validation = true


}
output "acm_arn" {
  value = module.acm.acm_certificate_arn
}

variable "www_domain" {
  type = string
}
variable "non_www_domain" {
  type = string
}
data "aws_route53_zone" "hosted_zone" {
  name = "bookinglet.link"
}