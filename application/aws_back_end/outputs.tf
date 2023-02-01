output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}


output "public_subnets" {
  value = module.vpc.public_subnets
}
