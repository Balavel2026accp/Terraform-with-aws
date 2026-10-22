# local block values
locals {
  Owner = "${var.Business-unit}-${var.Environment}"
  environment = var.Environment
  name = "${var.Business-unit}-${var.Environment}"
  common_tags = {
    Owner = local.Owner
    environment = local.environment
  }
}