# creating alb using aws public registry module
module "app-alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.1"
  name    = local.name
  vpc_id  = module.vpc-1.vpc_id
  subnets = module.vpc-1.public_subnets
  load_balancer_type = var.load_balancer_type
  security_groups = module.load-balancer-security-group.id
  tags = local.common_tags

  listeners = {
    tyy-tg-80 = {
      port            = 80
      protocol        = "HTTP"
      #certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"

      forward = {
        target_group_key = "tyy-tg"
      }
    }
  }

  target_groups = {
    tyy-tg = {
      create_attachment = false  
      name_prefix                       = "h1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
      protocol_version = "HTTP1"
      #target_id        = aws_instance.this.id
      port             = 80

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

     
      tags = local.common_tags
    }
}   

}

# Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "tyy-tg" {
  for_each = {for k, v in module.ec2-instance-private: k => v}
  target_group_arn = module.app-alb.target_groups["tyy-tg"].arn
  target_id        = each.value.id
  port             = 80
}

## k = ec2_instance
## v = ec2_instance_details

## TEMP App Outputs
output "zz_ec2_private" {
  #value = {for k, v in module.ec2_private: k => v}
  value = {for ec2_instance, ec2_instance_details in module.ec2-instance-private: ec2_instance => ec2_instance_details}
}