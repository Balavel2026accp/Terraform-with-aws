
# ============================================================
# APPLICATION LOAD BALANCER
# ============================================================

module "app-alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.1"

  name               = local.name
  vpc_id             = module.vpc-1.vpc_id
  subnets            = module.vpc-1.public_subnets
  load_balancer_type = var.load_balancer_type

  security_groups = [
    module.load-balancer-security-group.id
  ]

  tags = local.common_tags

  # ----------------------------------------------------------
  # LISTENERS
  # ----------------------------------------------------------

  listeners = {

    # HTTP -> HTTPS redirect
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"

      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    # HTTPS listener
    ex-https = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn

      # Default response for unmatched requests
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }

      # ------------------------------------------------------
      # LISTENER RULES
      # ------------------------------------------------------

      rules = {

        # Rule 1: App1
        myapp1-rule = {
          priority = 10

          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "tyy-tg"
                  weight           = 1
                }
              ]

              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/app1", "/app1/*"]
            }
          }]
        }

        # Rule 2: App2
        myapp2-rule = {
          priority = 20

          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "tyy-tg-app2"
                  weight           = 1
                }
              ]

              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/app2", "/app2/*"]
            }
          }]
        }
      }
    }
  }

  # ----------------------------------------------------------
  # TARGET GROUPS
  # ----------------------------------------------------------

  target_groups = {

    # App1 Target Group
    tyy-tg = {
      create_attachment = false

      name_prefix = "h1"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"

      deregistration_delay = 10

      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

      protocol_version = "HTTP1"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = "2"
        }

        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = "50"
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

    # App2 Target Group
    tyy-tg-app2 = {
      create_attachment = false

      name_prefix = "h2"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"

      deregistration_delay = 10

      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

      protocol_version = "HTTP1"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = "2"
        }

        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = "50"
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
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


# ============================================================
# TARGET GROUP ATTACHMENTS
# ============================================================

# App1 EC2 instances
resource "aws_lb_target_group_attachment" "tyy-tg" {

  for_each = module.ec2-instance-private-app1

  target_group_arn = module.app-alb.target_groups["tyy-tg"].arn

  target_id = each.value.id
  port      = 80
}


# App2 EC2 instances
resource "aws_lb_target_group_attachment" "tyy-tg-app2" {

  for_each = module.ec2-instance-private-app2

  target_group_arn = module.app-alb.target_groups["tyy-tg-app2"].arn

  target_id = each.value.id
  port      = 80
}


# ============================================================
# TEMPORARY EC2 OUTPUTS
# ============================================================

output "zz_ec2_private_app1" {
  value = {
    for ec2_instance, ec2_instance_details in module.ec2-instance-private-app1 :
    ec2_instance => ec2_instance_details
  }
}

output "zz_ec2_private_app2" {
  value = {
    for ec2_instance, ec2_instance_details in module.ec2-instance-private-app2 :
    ec2_instance => ec2_instance_details
  }
}
