## creating sg for bastion host using aws public module 
module "bashtion-security-gp" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  vpc_id = module.vpc-1.vpc_id
  description = "Sg for ingress open for IPV4 at port 22 ssh, egress open for all outter network"
  name = var.bashtion-sg-name

  # ingress rule 
  ingress_rules = {
    ssh-from-anywhere = {
        from_port   = 22
        to_port     = 22
        ip_protocol = "tcp"
        cidr_ipv4   = "0.0.0.0/0"
        description = "SSH from anywhere to bastion host"
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
