# creating security group for load balancer.. 
module "load-balancer-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"
# insert the 2 required variables here
  name = local.sg_LB
  vpc_id = module.vpc-1.vpc_id

  ingress_rules = {
  http-from-internet = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow HTTP from internet"
  }

  port-81-from-internet = {
    from_port   = 81
    to_port     = 81
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow Port 81 from internet"
  }
}

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "All outbound"
    }
  }
  
  tags = local.common_tags
}