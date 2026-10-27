## creating sg for bastion host using aws public module 
module "private-security-gp" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  vpc_id = module.vpc-1.vpc_id
  description = "sg ingress open form the VPCcidr block range and egress open to all"
  name = var.private-sg-name

  # ingress rule 
  ingress_rules = {
  ssh-from-vpc = {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr_ipv4   = module.vpc-1.vpc_cidr_block
    description = "SSH from VPC CIDR block"
  }

  http-from-vpc = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = module.vpc-1.vpc_cidr_block
    description = "HTTP from VPC CIDR block"
  }
}
  
  # egress rule 
  egress_rules = {
    all-outbound = {
    ip_protocol = "-1"
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow all outbound IPv4 traffic to internet"
  }
  }

  tags = local.common_tags
}
