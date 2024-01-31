# create zone and non alb/cloudfront dns records
module "zone_and_records" {
  source = "./modules/route53"

  zone         = var.zone
  create_zone  = var.create_zone
  private_zone = var.private_zone
  records = [for record in var.records : {
    name  = record.name
    type  = lookup(record, "type", "A")
    value = coalesce(lookup(record, "value", null), [])
  } if !contains(["alb", "cdn"], record.target_type)]
}

# alb records
module "alb_records" {
  source = "./modules/record-alias-alb"

  for_each = { for record in var.records : "${record.name}-${record.set_identifier == null ? "primary" : record.set_identifier}" => record if record.target_type == "alb" }

  zone_id                    = module.zone_and_records.zone_id
  name                       = each.value.name
  alb                        = each.value.alb
  geolocation_routing_policy = try(each.value.geolocation_routing_policy, {})
  set_identifier             = try(each.value.set_identifier, null)
}

# cloudfront records
module "cdn_records" {
  source = "./modules/record-alias-cdn"

  for_each = { for record in var.records : record.name => record if record.target_type == "cdn" }

  zone_id         = module.zone_and_records.zone_id
  name            = each.value.name
  distribution_id = each.value.distribution_id
}
