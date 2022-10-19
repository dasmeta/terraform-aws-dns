resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.cdn.domain_name
    zone_id                = data.aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = true
  }
}
