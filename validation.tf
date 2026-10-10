data "aws_ec2_instance_type_offerings" "my_instance" {
 for_each = toset(data.aws_availability_zones.az-us-east-1.names)  
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}

