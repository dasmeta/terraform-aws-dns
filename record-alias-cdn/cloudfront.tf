data "aws_cloudfront_distribution" "cdn" {
  id = var.distribution_id
}
