module "this" {
  source = "../../"

  zone = "devops.dasmeta.com"

  records = [
    {
      name  = "test-a"
      type  = "A"
      value = ["127.0.0.1"]
    }
  ]
}
