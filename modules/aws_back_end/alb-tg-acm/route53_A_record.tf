resource "aws_route53_record" "www" {
  zone_id = "Z03030356MARD7N1HBSL"
  name    = "api.bookinglet.link"
  type    = "A"
  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = data.aws_lb_hosted_zone_id.app.id
    // every aws resource also has their own zone_id   or we can say host id.
    evaluate_target_health = true
  }
#   lifecycle {
#     create_before_destroy = true
#   }
}

data "aws_lb_hosted_zone_id" "app" {}