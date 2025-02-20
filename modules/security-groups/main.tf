# Security Group for Public EC2 Instances
resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "Security group for ${var.sg_name}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value["f_port"]
      to_port = ingress.value["t_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
 dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value["f_port"]
      to_port     = egress.value["t_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
  
}

