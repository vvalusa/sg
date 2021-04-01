locals {
    valid_ingress = [
        for rule in var.ingress:
        rule
        if length(rule.cidr_blocks) > 0
    ]
    valid_egress = [
        for rule in var.egress:
        rule
        if length(rule.cidr_blocks) > 0
    ]
}


resource "aws_security_group" "security_group" {
  vpc_id      = var.vpc_id
  name = var.name
  description = var.description

  dynamic "ingress" {
      for_each = local.valid_ingress
      content {
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_blocks
          description = ingress.value.description
      }
  }
  dynamic "egress" {
      for_each = local.valid_egress
      content {
          from_port = egress.value.from_port
          to_port = egress.value.to_port
          protocol = egress.value.protocol
          cidr_blocks = egress.value.cidr_blocks
          description = egress.value.description
      }
  }
  lifecycle {
      create_before_destroy = true
      ignore_changes = [
          name
      ]
  }
}