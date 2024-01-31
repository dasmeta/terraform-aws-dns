variable "zone" {
  type        = string
  description = "DNS Zone name record will be injected into"
}

variable "create_zone" {
  type        = bool
  description = "Create zone or use existing zone as data"
  default     = false
}

variable "private_zone" {
  type        = bool
  default     = false
  description = "If Route53 zone is private set var is true"
}

variable "records" {
  type = list(object({
    name        = string
    target_type = optional(string, "") # for cdn/alb record easy creation can be "alb", "cdn"

    type  = optional(string, "A")   # type for standard records creation, can be "A", "CNAME", "TEXT", and etc
    value = optional(list(any), []) # value for standard records creation

    alb = optional(string, null) # the name of loadbalancer

    distribution_id = optional(string, null) # cloudfront distribution id

    set_identifier : optional(string, null)        # for setting custom identifier in case we have multiple records(geo routing) for same domain
    geolocation_routing_policy : optional(any, {}) # use to define custom routing for each geo location
  }))
  description = "DNS Record map"
  default     = []
}
