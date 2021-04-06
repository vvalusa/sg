resource "aws_security_group" "security_group" {
  vpc_id      = var.vpc_id
  name        = var.name
  description = var.description

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      description     = ingress.value.description
      security_groups = ingress.value.security_groups

    }

  }
  dynamic "egress" {
    for_each = var.egress
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      description     = egress.value.description
      security_groups = egress.value.security_groups

    }
  }
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )

}
