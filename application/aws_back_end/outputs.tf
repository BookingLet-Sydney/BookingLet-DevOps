output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}


output "public_subnets" {
  value = module.vpc.public_subnets
}


output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}


output "zone_id_for_alb" {
  value = data.aws_lb_hosted_zone_id.app.id
}


output "host_zone_id_for_bookinglet" {
  value = data.aws_route53_zone.selected.zone_id
}

output "target_group_name" {
  value = module.alb-tg-acm.target_group_name
}
