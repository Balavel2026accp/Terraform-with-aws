output "public_dns_list" {
    description = "The instance public dns list"
    value = [for instance in aws_instance.myec2vm: instance.public_dns]
}

output "public_dns_map" {
    description = "The instance public dns map"
    value = {
  for instance in aws_instance.myec2vm :
  instance.tags["Name"] => instance.public_dns
}
}

output "public_dns_dict_AD" {
    description = "The instance public dns --AD"
    value = {
  for c, instance in aws_instance.myec2vm :
  c => instance.public_dns
}
}

## not recommended as logic is no valid with tag in loop value
output "public_dns_dict_AD-tag" {
    description = "The instance public dns --AD"
    value = {
  for key, instance in aws_instance.myec2vm :
  tags["Name"] => instance.public_dns
}
}

## splat operator.. old way 
output "public_ip-splat" {
    description = "public ip "
    value = aws_instance.myec2vm.*.public_ip

}

## splat operator.. latest way 
output "public_ip-splat" {
    description = "public ip "
    value = aws_instance.myec2vm[*].public_ip

}