mock_provider "aws" {}

run "duplicate_name_and_type" {
  command = plan

  variables {
    zone = "example.com"
    records = [
      { name = "example.com", type = "A", value = ["192.0.2.10"] },
      { name = "example.com", type = "A", value = ["192.0.2.11"] },
    ]
  }
}
