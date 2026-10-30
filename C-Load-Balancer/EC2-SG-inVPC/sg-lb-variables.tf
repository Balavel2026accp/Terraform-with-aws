# sg load balancer name
variable "sg-LB" {
  description = "defining sg name for laod balancer"
  type = string
  default = "${var.Environment}-sg-LB"
}