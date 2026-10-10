data "aws_availability_zones" "az-us-east-1" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "my_instance" {
 for_each = toset(data.aws_availability_zones.az-us-east-1.names)  
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}

output "instance_types" {
  description = "validated ins_type"
  value = [for instance_type in data.aws_ec2_instance_type_offerings.my_instance: instance_type.instance_types]
}

output "instance_types_map" {
  description = "validated ins_type"
  value = keys({for az, instance in data.aws_ec2_instance_type_offerings.my_instance: az => instance.instance_types })
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
