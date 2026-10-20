# main terraform file for vpc; using aws vpc module forn registry
module "vpc-1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  # Information for vpc 
  name   = var.VPCname
  cidr = var.vpc_cidr

  # az and subnet details
  azs                 = ["ap-south-1a", "ap-south-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]
  # This creates the database subnet group automatically
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  create_database_internet_gateway_route = false
  create_database_nat_gateway_route = false
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]

  # Nat gateways for outbout communication from the private subnet systems 
  enable_nat_gateway = true

  # avoid bill eleveation we are creating with single NATGATEWAYS
  single_nat_gateway = true

  # configuriong dns details 
  enable_dns_hostnames = true
  enable_dns_support = true

  # details for subnets tags
  public_subnet_tags = {
    Name = "public-subnet"
  }

  private_subnet_tags = {
    Name = "private-subnet"
  }

  database_subnet_tags = {
    Name = "DATA-subnet"
  }

  # command tags
  tags = {
    Owner = "Balasundaravel"
    Ennvironment = "Dev"
  }
  # vpc tag
  vpc_tags = {
    Name = "VPC-DEV"
  }
}