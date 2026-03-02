terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.41"
    }
  }

  required_version = ">= 1.3.0"
}

/**
 * set the following env vars so that aws provider will get authenticated before apply:
 *
 *   export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxxxxxx
 *   export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxx
 */
provider "aws" {
  region = "eu-central-1"
}

# Domain for the private DNS zone
variable "domain" {
  type        = string
  description = "Domain name for the private DNS zone"
  default     = "private.devops.dasmeta.com"
}

# Resolve VPC IDs to associate with the private zone (default VPC in the region)
data "aws_vpcs" "ids" {
  tags = {
    Name = "default"
  }
}
