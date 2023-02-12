module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = var.domain_name
  zone_id     = var.route53_zone_id

  subject_alternative_names = [
    # "*.bookinglet.link",
    "api.${var.domain_name}"
  ]

  wait_for_validation = true

  tags = {
    Name = "api.${var.domain_name}"
  }
}
