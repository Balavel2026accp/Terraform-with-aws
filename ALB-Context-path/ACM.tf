# creating acm entry for having ssl
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = trimsuffix(data.aws_route53_zone.my-domain-zone.name, ".")
  zone_id      = data.aws_route53_zone.my-domain-zone.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.CyberaracINfro.com"
  ]

  wait_for_validation = true

  tags = local.common_tags
}

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}