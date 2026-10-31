# VPC Input Variables

# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "Myvpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# vpc availability zones
variable "azs" {
    description = "list of az where we need to create the subnets inside the vpc"
    type = list 
    #default = ["ap-south-1a", "ap-south-1b"] 
    default = []
}

variable "private_subnets" {
    description = "list of private_subnets where we need to create the subnets inside the vpc"
    type = list 
    #default = ["ap-south-1a", "ap-south-1b"] 
    default = []
}

variable "public_subnets" {
    description = "list of public_subnets where we need to create the subnets inside the vpc"
    type = list 
    #default = ["ap-south-1a", "ap-south-1b"] 
    default = []
}

variable "create_database_subnet_group" {
  description = "Confirms we need database creats in separate subnets"
  type = bool
  default = false
}

variable "create_database_subnet_route_table" {
  description = "Confirms we need database creats in separate subnets"
  type = bool
  default = false
}

variable "create_database_internet_gateway_route" {
  description = "creates route-table form database subnet to igw"
  type = bool
  default = false
}

variable "create_database_nat_gateway_route" {
  description = "creates route-table form database subnet to NAT"
  type = bool
  default = false
}

variable "database_subnets" {
  description = "subnets on which range database shoulb be created"
  type = list 
  default = []
}


variable "enable_nat_gateway" {
  description = "Create routable from private to NAT" 
  type = bool
  default = false
}

variable "single_nat_gateway" {
  description = "create one NAT and route all through it [Avoiding extra-Cost Allowed: lab-type only]"
  type = bool
  default = false
}