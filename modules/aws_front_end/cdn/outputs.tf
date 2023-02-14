output "www_cdn_domain_name" {
  value = aws_cloudfront_distribution.www_domain.domain_name
}
output "non_www_cdn_domain_name" {
  value = aws_cloudfront_distribution.non_www_domain.domain_name

}
output "www_cdn_zone_id" {
  value = aws_cloudfront_distribution.www_domain.hosted_zone_id
}
output "non_www_cdn_zond_id" {
  value = aws_cloudfront_distribution.non_www_domain.hosted_zone_id

}
