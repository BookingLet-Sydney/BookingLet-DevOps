module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = "bookinglet.link"
  zone_id      = "Z03030356MARD7N1HBSL"

  subject_alternative_names = [
    # "*.bookinglet.link",
    "api.bookinglet.link"
  ]

  wait_for_validation = true

  tags = {
    Name = "bookinglet.link"
  }
}