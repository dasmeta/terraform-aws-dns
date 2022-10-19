variable "zone" {
  type        = string
  description = "DNS Zone name record will be injected into"
}

variable "create_zone" {
  type        = bool
  description = "Create zone or use existing zone as data"
  default     = false
}

variable "records" {
  type        = list(any)
  description = "DNS Record map"
  default     = []
}
