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

 export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxxxxxx
 export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxx
*/
provider "aws" {
  region = "eu-central-1"
}

resource "aws_default_subnet" "default_az_a" {
  availability_zone = "eu-central-1a"
}

resource "aws_default_subnet" "default_az_b" {
  availability_zone = "eu-central-1b"
}

resource "aws_lb" "test" {
  name               = "dns-test-lb-tf"
  internal           = false
  load_balancer_type = "application"

  subnets = [aws_default_subnet.default_az_a.id, aws_default_subnet.default_az_b.id]
}
