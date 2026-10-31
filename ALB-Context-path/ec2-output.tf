# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "EC2 instance ID"
  value       = module.ec2-instance-bashtion.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "Public IP address EC2 instance"
  value       = module.ec2-instance-bashtion.public_ip 
}

# Private EC2 Instances
## ec2_private_instance_ids
output "ec2_private_instance_ids-app1" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2-instance-private-app1: ec2private.id ]   
}

## ec2_private_instance_ids
output "ec2_private_instance_ids-app2" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2-instance-private-app2: ec2private.id ]   
}

## ec2_private_ip
output "ec2_private_ip-app1" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2-instance-private-app1: ec2private.private_ip ]  
}

output "ec2_private_ip-app2" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2-instance-private-app2: ec2private.private_ip ]  
}