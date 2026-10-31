## data source for get hosted zone
data "aws_route53_zone" "my-domain-zone" {
  name         = "CyberaracINfro.com"
  private_zone = false
}
#output

output "my-hosted-zone-id"{
  describtion = "Directly return the Hosted Zone with the specified Zone ID. No further filtering is performed."
  value = data.aws_route53_zone.my-domain-zone.zone_id
}

output "my-hosted-name"{
  describtion = "Directly return the Hosted Zone with the specified Zone ID. No further filtering is performed."
  value = data.aws_route53_zone.my-domain-zone.name
}