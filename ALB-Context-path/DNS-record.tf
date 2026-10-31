esource "aws_route53_record" "mycom" {
  zone_id = data.aws_route53_zone.my-domain-zone.zone_id
  name    = "cyberapp.com"
  type    = "A"

  alias {
    name                   = module.app-alb.dns_name
    zone_id                = module.app-alb.zone_id
    evaluate_target_health = true
  }
}
