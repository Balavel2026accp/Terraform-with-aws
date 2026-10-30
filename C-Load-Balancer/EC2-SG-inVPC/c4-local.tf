# local block values
locals {
  Owner = "${var.Business-unit}-${var.Environment}"
  environment = var.Environment
  name = "${var.Business-unit}-${var.Environment}"
  common_tags = {
    Owner = local.Owner
    environment = local.environment
  }

  private_subnets = {  
  private_subnet1 = module.vpc-1.private_subnets[0]
  private_subnet2 = module.vpc-1.private_subnets[1]
  }


  load_balancer_name = "${var.Environment}-${var.Business-unit}-ELB"
  sg_LB              = "${var.Environment}-SGLB"

}

