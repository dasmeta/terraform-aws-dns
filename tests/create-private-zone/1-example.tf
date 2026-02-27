# Private DNS zone for routing traffic internally (e.g. domain resolving to internal load balancer)
module "this" {
  source = "../.."

  zone         = var.domain
  create_zone  = true
  private_zone = true
  records      = []
  vpc_ids      = data.aws_vpcs.ids.ids
}
