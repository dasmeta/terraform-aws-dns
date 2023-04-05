module "this" {
  source = "../../"

  zone = "devops.dasmeta.com"

  records = [
    {
      target_type = "alb"
      name        = "test-alb"
      alb         = aws_lb.test.name
    }
  ]

  depends_on = [
    aws_lb.test
  ]
}
