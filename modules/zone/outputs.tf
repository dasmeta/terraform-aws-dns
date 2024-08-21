output "zone_id" {
  value       = aws_route53_zone.main.zone_id
  description = "Return created zone id."
}

output "arn" {
  value       = aws_route53_zone.main.arn
  description = "Return created zone arn."
}

output "name_servers" {
  value       = aws_route53_zone.main.name_servers
  description = "Return created zone name_servers."
}
