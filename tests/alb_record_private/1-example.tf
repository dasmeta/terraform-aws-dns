module "this" {
  source = "../../"

  private_zone = true
  zone         = "dasmeta.com"
  records = [
    {
      target_type = "alb"
      name        = "frontend-test"
      alb         = "test-internal"
    }
  ]
}
