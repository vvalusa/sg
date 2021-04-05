## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/3.35.0/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of Security group | `string` | n/a | yes |
| <a name="input_egress"></a> [egress](#input\_egress) | List of egress rules | <pre>map(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = list(string)<br>    description     = string<br>    security_groups = list(string)<br><br>  }))</pre> | n/a | yes |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | List of ingress rules | <pre>map(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = list(string)<br>    description     = string<br>    security_groups = list(string)<br><br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of Security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mention the tags | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the security group |
| <a name="output_id"></a> [id](#output\_id) | The ID of the security group |

## Usage

Here is examples of how you can use this module, we created 2 different type of groups i.e. open to public access, and DB security groups.

### Security group with custom rules

```hcl
module "sg_public" {
  source   = "../sg/"
  vpc_cidr = var.vpc_cidr
  vpc_id   = var.vpc_id
  ingress = {
    "http_rules_ingress" = {
      description     = "For HTTP"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    },
    "ssh_rules_ingress" = {
      description     = "For SSH"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  }
  egress = {
    "Internet_open_egress" = {
      description     = "Internet open egress"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  }
  name        = "Public security group"
  description = "Public secuirty group"
  tags        = "nginx_service"
}


module "sg_rds" {
  source   = "../sg/"
  vpc_cidr = var.vpc_cidr
  vpc_id   = var.vpc_id
  ingress = {
    "http_rules_ingress" = {
      description     = "For HTTP"
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = ["sg-035962aecd67def34"]
    }
  }
  egress = {
    "Internet_open_egress" = {
      description     = "Internet RDS egress"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  }
  name        = "RDS security group"
  description = "RDS secuirty group"
  tags        = "rds_sg"
}

```



