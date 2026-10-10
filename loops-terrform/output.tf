# output "public_dns_list" {
#     description = "The instance public dns list"
#     value = [for instance in aws_instance.myec2vm: instance.public_dns]
# }

# output "public_dns_map" {
#     description = "The instance public dns map"
#     value = {
#   for instance in aws_instance.myec2vm :
#   instance.tags["Name"] => instance.public_dns
# }
# }

# output "public_dns_dict_AD" {
#     description = "The instance public dns --AD"
#     value = {
#   for c, instance in aws_instance.myec2vm :
#   c => instance.public_dns
# }
# }

# ## not recommended as logic is no valid with tag in loop value
# output "public_dns_dict_AD-tag" {
#     description = "The instance public dns --AD"
#     value = {
#   for key, instance in aws_instance.myec2vm :
#   instance.tags["Name"] => instance.public_dns
# }
# }

/*
The splat (`*`) expression works naturally with resources created using `count`
because Terraform stores their instances as an indexed collection.

Example:
aws_instance.example[*].public_ip
Returns a list of public IP addresses for all instances.

With `for_each`, Terraform identifies instances by their map keys
(e.g., "dev", "qual", "prod") rather than numeric indexes.

Example:
aws_instance.example["dev"].public_ip
aws_instance.example["qual"].public_ip

Therefore, `for_each` resources are accessed using their keys when
referencing individual instances. To collect an attribute from all
instances, use a for expression:

[for instance in aws_instance.example : instance.public_ip]

Note: Splat expressions do not directly support resources created with
`for_each` because they are represented as maps, not lists.
*/
/*## splat operator.. old way 
output "public_ip-splat" {
    description = "public ip "
    value = aws_instance.myec2vm.*.public_ip
} */ 

# ## splat operator.. latest way 
# # output "public_ip-splat_latest" {
# #     description = "public ip "
# #     value = aws_instance.myec2vm[*].public_ip
# }

output "instance_dns" {
  description = "PLublic dns for the the instance"
  value = toset([for instance in aws_instance.myec2vm: instance.public_dns ])
}

output "instance_ip" {
  description = "PLublic IP for the the instance"
  value = { for az, instance in aws_instance.myec2vm: az => instance.public_ip}
}
