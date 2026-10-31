# public instance type
variable "instance_type" {
  type = string
  default = "t3.micro"
}


# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

## instance count for the bashtion 
variable "instance_cout" {
  type = number
  default = 1
}


# keyname 
variable "key_name" {
    type = string
    default = "terraform-key"
}

variable "private_instance_count" {
  type  = number
  default = 1
}