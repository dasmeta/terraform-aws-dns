resource "aws_route53_record" "www" {
  zone_id        = var.zone_id
  name           = var.name
  type           = "A"
  set_identifier = var.set_identifier

  alias {
    name                   = "dualstack.${data.aws_lb.alb.dns_name}"
    zone_id                = data.aws_lb.alb.zone_id
    evaluate_target_health = true
  }

  dynamic "geolocation_routing_policy" {
    for_each = length(keys(var.geolocation_routing_policy)) == 0 ? [] : [true]

    content {
      continent   = lookup(var.geolocation_routing_policy, "continent", null)
      country     = lookup(var.geolocation_routing_policy, "country", null)
      subdivision = lookup(var.geolocation_routing_policy, "subdivision", null)
    }
  }
}
