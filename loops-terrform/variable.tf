# Input Variables
# AWS Region

variable "region" {
  type = string
}

# variable "aws_region" {
#   description = "Region in which AWS Resources to be created"
#   type = string
#   default = "us-east-1"
# }

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instnace Type"
  type = string
  default = "t3.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "terraform-key"
}

variable "instance_type_list" {
  description = "EC2 Instnace Type"
  type = list(string)

}

variable "instance_type_map" {
  description = "EC2 Instnace Type"
  type = map(string)

}