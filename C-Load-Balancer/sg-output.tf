## gathering output for both security groups
# AWS EC2 Security Group Terraform Outputs

# Public Bastion Host Security Group Outputs
## public_bastion_sg_group_id
output "public_bastion_sg_group_id" {
  description = "The ID of the security group"
  #value       = module.public_bastion_sg.this_security_group_id
  # value       = module.bashtion-security-gp.security_group_id
  value       = module.bashtion-security-gp.id
}

## public_bastion_sg_group_vpc_id
output "bashtion-security-gp_vpc_id" {
  description = "The VPC ID"
  # value       = module.public_bastion_sg.this_security_group_vpc_id
  # value       = module.bashtion-security-gp.security_group_vpc_id
  value       = module.bashtion-security-gp.vpc_id
}

## public_bastion_sg_group_name
output "public_bastion_sg_group_name" {
  description = "The name of the security group"
  #value       = module.public_bastion_sg.this_security_group_name
  value       = module.bashtion-security-gp.name
}

# bashtion-security-gp arn value
output "public_bastion_sg_group_arn" {
  description = "The arn -value of the security group"
  #value       = module.public_bastion_sg.this_security_group_name
  value       = module.bashtion-security-gp.arn
}
# Private EC2 Instances Security Group Outputs
## private_sg_group_id
output "private_sg_group_id" {
  description = "The ID of the security group"
  #value       = module.private_sg.this_security_group_id
  value       = module.private-security-gp.id
}

## private_sg_group_vpc_id
output "private_sg_group_vpc_id" {
  description = "The VPC ID"
  #value       = module.private_sg.this_security_group_vpc_id
  value       = module.private-security-gp.vpc_id
}

## private_sg_group_name
output "private_sg_group_name" {
  description = "The name of the security group"
  #value       = module.private_sg.this_security_group_name
  value       = module.private-security-gp.name
}

# bashtion-security-gp arn value
output "private_sg_group_name_arn" {
  description = "The arn -value of the security group"
  #value       = module.public_bastion_sg.this_security_group_name
  value       = module.private-security-gp.arn
}