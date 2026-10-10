## data source for avz 
data "aws_availability_zones" "az-us-east-1" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
