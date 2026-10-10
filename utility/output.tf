output "instance_types" {
  description = "validated ins_type"
  value = [for instance_type in data.aws_ec2_instance_type_offerings.my_instance: instance_type.instance_types]
}

output "instance_types_map" {
  description = "validated ins_type"
  value = {for az, instance in data.aws_ec2_instance_type_offerings.my_instance: az => instance.instance_types }
}

output "instance_types_map-v1" {
  description = "validated ins_type"
  value = keys({for az, instance in data.aws_ec2_instance_type_offerings.my_instance: az => instance.instance_types 
  if (instance.instance_types) != 0})
}


output "instance_types_map-v2" {
  description = "validated ins_type"
  value = keys({for az, instance in data.aws_ec2_instance_type_offerings.my_instance: az => instance.instance_types 
  if (instance.instance_types) != 0 })[0]
}