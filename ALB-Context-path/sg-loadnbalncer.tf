# creating security group for load balancer.. 
module "load-balancer-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"
# insert the 2 required variables here
  name = local.sg_LB
  vpc_id = module.vpc-1.vpc_id

  ingress_rules = {
    http-from-vpc = {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"
    description = "HTTP from VPC CIDR block"
  }

  https-from-internet = {
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  description = "Allow HTTPS (443) from internet"
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