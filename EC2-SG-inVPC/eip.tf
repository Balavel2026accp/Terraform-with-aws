# creating eip for bashtion host to 

resource "aws_eip" "Bashtion" {
  depends_on = [module.vpc-1, module.ec2-instance-bashtion]  
  instance = module.ec2-instance-bashtion.id
  domain   = "vpc"

  tags = local.common_tags
}

/*
Important distinction
- depends_on = [module.vpc-1] — waits for the VPC module's resources.
- depends_on = [aws_internet_gateway.example] — waits for that specific IGW resource, if it is managed directly in the same configuration.
- depends_on = [module.vpc-1.igw_id] — invalid because an output value is not a valid dependency reference.
*/