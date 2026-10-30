# Creating elb to archestrate the traffic
locals {
  instance_count = length(module.ec2-instance-private)
}

module "Dev-elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.3"

  name = var.load-balancer-name

  subnets         = [
    module.vpc-1.public_subnets[0], 
    module.vpc-1.public_subnets[1]
    ]
  security_groups = [module.load-balancer-security-group.id]
  #internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 81
      lb_protocol       = "http"
      #ssl_certificate_id = "arn:aws:acm:eu-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

 /* access_logs = {
    bucket = "my-access-logs-bucket"
  } */

  // ELB attachments
  number_of_instances = local.instance_count
  #instances           = local.instance_count
  instances = [for private_instance in mudule.ec2-instance-private: ec2-instance-private.id]

  tags = local.common_tags
}
