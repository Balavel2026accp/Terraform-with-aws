module "ec2-instance-bashtion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.1"

  name = "${local.name}-Bashtion-instance"
  #count = var.instance_cout
  #monitoring = true
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type # used to set core count below
  key_name = var.key_name
  subnet_id              = module.vpc-1.public_subnets[0]
  # vpc_security_group_ids = [module.bashtion-security-gp.security_group_id] 
  vpc_security_group_ids = [module.bashtion-security-gp.id] 
  #user_data = file("${path.module}/app1-install.sh")

  tags = local.common_tags
}