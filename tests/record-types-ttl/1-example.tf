module "this" {
  source = "../../"

  zone        = "example.com"
  create_zone = true

  records = [
    {
      name  = "example.com"
      type  = "A"
      value = ["192.0.2.10"]
    },
    {
      name  = "example.com"
      type  = "TXT"
      value = ["verification=example"]
      ttl   = 300
    },
  ]
}
