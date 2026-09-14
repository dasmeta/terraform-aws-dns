mock_provider "aws" {
  mock_data "aws_route53_zone" {
    defaults = {
      zone_id = "Z0123456789"
    }
  }

  mock_data "aws_lb" {
    defaults = {
      dns_name = "demo-alb.example.com"
      zone_id  = "Z0123456789"
    }
  }

  mock_data "aws_cloudfront_distribution" {
    defaults = {
      domain_name    = "demo.cloudfront.net"
      hosted_zone_id = "Z2FDTNDATAQYW2"
    }
  }
}

variables {
  zone = "example.com"
}

run "individual_ttl" {
  command = plan

  variables {
    records = [{ name = "example.com", type = "TXT", value = ["verification=example"], ttl = 300 }]
  }
}

run "same_name_different_types" {
  command = plan

  variables {
    records = [
      { name = "example.com", value = ["192.0.2.10"] },
      { name = "example.com", type = "TXT", value = ["verification=example"], ttl = 300 },
    ]
  }
}

run "reordered_records" {
  command = plan

  variables {
    records = [
      { name = "example.com", type = "TXT", value = ["verification=example"], ttl = 300 },
      { name = "example.com", value = ["192.0.2.10"] },
    ]
  }
}

run "change_one_ttl" {
  command = plan

  variables {
    records = [
      { name = "example.com", value = ["192.0.2.10"], ttl = 60 },
      { name = "example.com", type = "TXT", value = ["verification=example"], ttl = 300 },
    ]
  }
}

run "null_ttl" {
  command = plan

  variables {
    records = [{ name = "example.com", value = ["192.0.2.10"], ttl = null }]
  }
}

run "empty_records" {
  command = plan

  variables {
    records = []
  }
}

run "aliases_unchanged" {
  command = plan

  variables {
    records = [
      { name = "alb.example.com", target_type = "alb", alb = "demo-alb", ttl = 300 },
      { name = "cdn.example.com", target_type = "cdn", distribution_id = "E0123456789", ttl = 300 },
    ]
  }
}
