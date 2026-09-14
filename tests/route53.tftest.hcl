mock_provider "aws" {
  mock_data "aws_route53_zone" {
    defaults = {
      zone_id = "Z0123456789"
    }
  }
}

run "submodule_default_ttl" {
  command = plan

  module {
    source = "./modules/route53"
  }

  variables {
    zone        = "example.com"
    create_zone = false
    records = [
      { name = "example.com", type = "A", value = ["192.0.2.10"] },
      { name = "example.com", type = "TXT", value = ["verification=example"], ttl = 300 },
    ]
  }

  assert {
    condition     = length(aws_route53_record.add_record) == 2
    error_message = "Different record types sharing a name must remain separate."
  }

  assert {
    condition     = aws_route53_record.add_record["example.com-A"].ttl == 30 && aws_route53_record.add_record["example.com-TXT"].ttl == 300
    error_message = "Omitted TTL must use 30 and individual TTL must override it."
  }
}

run "submodule_shared_ttl" {
  command = plan

  module {
    source = "./modules/route53"
  }

  variables {
    zone        = "example.com"
    create_zone = false
    ttl         = "120"
    records = [
      { name = "example.com", type = "A", value = ["192.0.2.10"] },
      { name = "example.com", type = "TXT", value = ["verification=example"], ttl = 300 },
      { name = "null.example.com", type = "A", value = ["192.0.2.11"], ttl = null },
      { name = "zero.example.com", type = "A", value = ["192.0.2.12"], ttl = 0 },
    ]
  }

  assert {
    condition     = aws_route53_record.add_record["example.com-A"].ttl == 120 && aws_route53_record.add_record["null.example.com-A"].ttl == 120
    error_message = "Omitted/null individual TTL must preserve the legacy shared TTL."
  }

  assert {
    condition     = aws_route53_record.add_record["example.com-TXT"].ttl == 300 && aws_route53_record.add_record["zero.example.com-A"].ttl == 0
    error_message = "Explicit individual TTL, including zero, must override the shared TTL."
  }
}
