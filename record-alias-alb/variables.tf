variable "name" {
  type        = string
  description = "DNS Record Name"
}

variable "zone_id" {
  type        = string
  description = "DNS Zone Id"
}

variable "alb" {
  type        = string
  description = "ALB Name"
}

variable "geolocation_routing_policy" {
  type        = any
  default     = null
  description = "Routing policy, for now only geolocation supported"
}

variable "set_identifier" {
  type        = any
  default     = null
  description = "Routing policy unique identifier"
}
