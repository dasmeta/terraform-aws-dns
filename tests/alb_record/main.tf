module "dns" {
  source = "../"

  zone        = "devops.dasmeta.com"
  create_zone = false

  records = [
    {
      target_type                = "alb"
      name                       = "test"
      alb                        = "dasmeta-dev"
      set_identifier             = null
      geolocation_routing_policy = {}
    }
  ]
}
