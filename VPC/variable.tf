# Region variable value
variable "region" {
  type = string
  default = "ap-south-1"
}

variable "VPCname" {
  type = string
  default = "Test-VPC"
}

# variable "VPCaz" {
#   type = list
#   default = ["ap-south-1a", "ap-south-1b"]
# }


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

