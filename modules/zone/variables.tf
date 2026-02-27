# variables
variable "name" {
  type        = string
  description = "Route53 Zone name"
}

variable "vpc_ids" {
  type        = list(string)
  description = "List of VPC IDs to associate with the Route53 Zone, if passed the zone will be private"
  default     = []
}
