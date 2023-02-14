resource "aws_route53_record" "www_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = var.www_domain
  type    = "A"

  alias {
    name                   = var.www_cdn_domain_name
    zone_id                = var.www_cdn_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "non_www_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = var.non_www_domain
  type    = "A"

  alias {
    name                   = var.non_www_cdn_domain_name
    zone_id                = var.non_www_cdn_zond_id
    evaluate_target_health = true
  }
}

