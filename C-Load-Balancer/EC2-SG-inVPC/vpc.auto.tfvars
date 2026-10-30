# VPC values
azs = ["ap-south-1a", "ap-south-1b"]
private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]
database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]
vpc_cidr_block = "10.0.0.0/16"
create_database_subnet_group = true
create_database_subnet_route_table = true
create_database_internet_gateway_route = false 
create_database_nat_gateway_route = false
enable_nat_gateway = true
single_nat_gateway = true