module "ec2-instance-private" {
  depends_on = [ module.vpc-1 ]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.1"

  for_each = local.private_subnets
  name = "${local.name}-private-instance"
  #count = var.private_instance_count
  #monitoring = true
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type # used to set core count below
  key_name = var.key_name
  #subnet_id              = module.vpc-1.public_subnets[0]
  subnet_id = each.value
  vpc_security_group_ids = [module.bashtion-security-gp.security_group_id] 
  user_data = file("${path.module}/app1-install.sh")

  tags = local.common_tags
}