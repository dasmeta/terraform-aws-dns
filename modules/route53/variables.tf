variable "zone" {
  type        = string
  description = "Route53 zone name"
}

variable "create_zone" {
  type        = bool
  default     = true
  description = "controlls whether create Route53 zone or use already created zone for just generating new records"
}

variable "private_zone" {
  type        = bool
  default     = false
  description = "If Route53 zone is private set var is true"
}

variable "vpc_ids" {
  type        = list(string)
  description = "List of VPC IDs to associate with the Route53 Zone, being used if only private_zone and create_zone are true"
  default     = []
}

variable "records" {
  type = list(object({
    name  = string,
    type  = string,
    value = set(string)
  }))
  description = "dns records name, type and value list"
  default     = []
}

variable "ttl" {
  type        = string
  default     = "30"
  description = "TTL Time"
}
