resource "aws_route53_record" "domain_name" {
  zone_id = var.route53_zone_id
  name    = "api.${var.domain_name}"
  type    = "A"
  alias {
    name    = aws_lb.app.dns_name
    zone_id = data.aws_lb_hosted_zone_id.app.id
    // this zone_id is not route53 zone id, 
    // each aws resource also has their own hosted_zone_id 
    // it is usually an identical id
    evaluate_target_health = true
  }
}

