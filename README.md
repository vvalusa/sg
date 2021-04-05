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
| <a name="input_egress"></a> [egress](#input\_egress) | List of egress rules | <pre>map(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = list(string)<br>    description     = string<br>    security_groups = list(string)<br><br>  }))</pre> | `{}` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | List of ingress rules | <pre>map(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = list(string)<br>    description     = string<br>    security_groups = list(string)<br><br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mention the tags | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
