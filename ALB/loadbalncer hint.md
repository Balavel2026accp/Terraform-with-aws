These three are AWS Application Load Balancer (ALB) Target Group attributes in Terraform. They control how the ALB distributes incoming requests across registered targets (EC2 instances, IP addresses, or other supported targets).

Let's understand each one from a production perspective.
1. load_balancing_algorithm_type = "weighted_random"
Traffic distribution
This determines how the ALB selects a target from the healthy registered targets.

AWS supports these target selection algorithms:
Algorithm	Explanation
round_robin	Distributes requests sequentially across targets.
least_outstanding_requests	Selects the target with the fewest outstanding requests.
weighted_random	Randomly selects targets using weighted probabilities.

Example:

Suppose your target group has three EC2 instances:
- EC2-A
- EC2-B
- EC2-C
With weighted_random, the ALB uses a weighted random selection approach rather than simply rotating through targets.

It is particularly useful with anomaly mitigation, which can identify targets behaving abnormally.
2. load_balancing_anomaly_mitigation = "on"
Fault detection and mitigation
This works with the weighted_random algorithm.

It enables automatic anomaly mitigation for targets showing abnormal response-time behaviour.

For example:
EC2 instance	Response time	Behaviour
EC2-A	100 ms	Normal
EC2-B	120 ms	Normal
EC2-C	2,000 ms	Potential anomaly

When anomaly mitigation is enabled, ALB can identify anomalous targets and reduce their traffic allocation.

Important: This is not the same as health checks.
- Health checks identify whether a target is healthy or unhealthy.
- Anomaly mitigation identifies targets with abnormal response-time behaviour.
3. load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
Availability Zone traffic distribution
This controls whether an ALB node can distribute traffic to targets registered in other Availability Zones.

Let's understand with an example.

Suppose you have two Availability Zones:
Availability Zone 1
ALB Node 1

EC2-A | EC2-B


Availability Zone 2
ALB Node 2

EC2-C | EC2-D


There are three possible configurations:
Value	Behaviour
"true"	ALB nodes can distribute traffic to targets across all enabled AZs.
"false"	Each ALB node distributes traffic only to targets in its own AZ.
"use_load_balancer_configuration"	Uses the load balancer's cross-zone configuration.

Example:

If cross-zone is disabled:
- ALB Node 1 → EC2-A, EC2-B
- ALB Node 2 → EC2-C, EC2-D
If cross-zone is enabled:
- ALB Node 1 → EC2-A, B, C, D
- ALB Node 2 → EC2-A, B, C, D
Important AWS detail: For Application Load Balancers, cross-zone load balancing is enabled at the load balancer level by default and cannot be disabled there. However, you can override it at the target group level by setting this attribute to "false". 
Elastic Load Balancing+1


4. How do these three work together?
Attribute	Main responsibility
load_balancing_algorithm_type	How to select a target
load_balancing_anomaly_mitigation	Reduce traffic to anomalous targets
load_balancing_cross_zone_enabled	Whether targets in other AZs can receive traffic

5. Terraform configuration
resource "aws_lb_target_group" "app" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc-1.vpc_id

  target_type = "instance"

  load_balancing_algorithm_type     = "weighted_random"
  load_balancing_anomaly_mitigation = "on"
  load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
}


6. Production-level considerations
A few important things to remember:
1. weighted_random is required for anomaly mitigation.
2. Weighted random does not support slow start or sticky sessions.
3. Anomaly mitigation is useful when targets experience abnormal errors but may still pass health checks.
4. Cross-zone settings affect how traffic is distributed across Availability Zones.

Elastic Load Balancing+2
My recommendation: For your multi-AZ ALB architecture, understand and start with round_robin as the default. Use weighted_random with anomaly mitigation when you have a specific need for automatic traffic mitigation. Keep cross-zone configuration at its default unless you have a reason to override it.