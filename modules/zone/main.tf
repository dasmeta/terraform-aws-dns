resource "aws_route53_zone" "main" {
  name = var.name

  dynamic "vpc" {
    for_each = var.vpc_ids
    content {
      vpc_id = vpc.value
    }
  }
}
