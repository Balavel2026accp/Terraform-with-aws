output "instance_types" {
  description = "validated ins_type"
  value = [for instance_type in data.aws_ec2_instance_type_offerings.my_instance: instance_types]
}