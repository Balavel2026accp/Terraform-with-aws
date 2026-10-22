# main terraform file for vpc; using aws vpc module forn registry
module "vpc-1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  # Information for vpc 
  name   = local.name
  cidr = var.vpc_cidr_block

  # az and subnet details
  azs                 = var.azs
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  # This creates the database subnet group automatically
  create_database_subnet_group = var.create_database_subnet_group
  create_database_subnet_route_table = var.create_database_subnet_route_table
  create_database_internet_gateway_route = var.create_database_internet_gateway_route
  create_database_nat_gateway_route = var.create_database_nat_gateway_route
  database_subnets    = var.database_subnets

  # Nat gateways for outbout communication from the private subnet systems 
  enable_nat_gateway = var.enable_nat_gateway

  # avoid bill eleveation we are creating with single NATGATEWAYS
  single_nat_gateway = true

  # configuriong dns details 
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = local.common_tags
  vpc_tags = local.common_tags

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
}