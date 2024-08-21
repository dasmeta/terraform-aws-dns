output "zone_id" {
  value       = module.zone_and_records.zone_id
  description = "zone id"
}

output "ns_delegation_set" {
  value       = [for item in module.zone_and_records.name_servers : "${item}."]
  description = "The NS records list for zone to use as delegation set"
}
