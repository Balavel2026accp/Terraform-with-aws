## data source for avz 
data "aws_availability_zones" "az-ap-south-1" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
