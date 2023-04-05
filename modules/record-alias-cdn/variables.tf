variable "name" {
  type        = string
  description = "DNS Record Name"
}

variable "zone_id" {
  type        = string
  description = "DNS Zone Id"
}

variable "distribution_id" {
  type        = string
  description = "Cloudfront Distribution Id"
}
