output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}


output "www_bucket_regional_domain_name" {
  value = module.s3.www_bucket_regional_domain_name
}
