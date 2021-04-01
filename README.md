# Security Group Terraform module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources
| Name | Type |
|------|------|
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Usage
Three different type of groups we created  	i.e. open to public access, open to VPC traffic and DB security groups.

### Security group with custom rules

Create main.tf for security groups.

```hcl
locals {
    vpc_cidr = var.vpc_cidr
    vpc_id = var.vpc_id
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    
    nginx_service = {
        ingress = [
            {
                description = "Nginx"
                cidr_blocks = ["0.0.0.0/0"]
                from_port = 80
                to_port = 80
                protocol = "tcp"
            },
            {
                description = "Nginx_Secure"
                cidr_blocks = ["0.0.0.0/0"]
                from_port = 443
                to_port = 443
                protocol = "tcp"
            },
            {
                description = "SSH"
                cidr_blocks = ["0.0.0.0/0"]
                from_port = 22
                to_port = 22
                protocol = "tcp"
            }
            ]
        egress = [
            {
                description = "Internet open egress"
                from_port   = 0
                to_port     = 0
                protocol    = "-1"
                cidr_blocks = ["0.0.0.0/0"]
            }
            ]
    }
    rds_cluster = {
        ingress = [
            {
                description = "Rds instances security groups"
                cidr_blocks = [local.vpc_cidr]
                from_port = 3306
                to_port = 3306
                protocol = "tcp"
            }
            ]
        egress =[]
    }
    internal = {
        ingress = [
            {
                description = "Internal Api Port"
                cidr_blocks = [local.vpc_cidr]
                from_port = 80
                to_port = 80
                protocol = "tcp"
            },
            {
                description = "Internal SSH Port"
                cidr_blocks = [local.vpc_cidr]
                from_port = 22
                to_port = 22
                protocol = "tcp"
            },
            {
                description = "Internal Api Port HTTPS"
                cidr_blocks = [local.vpc_cidr]
                from_port = 443
                to_port = 443
                protocol = "tcp"
            }
            ]
        egress = [
            {
                description = "Rds Client"
                cidr_blocks = [local.vpc_cidr]
                from_port = 3306
                to_port = 3306
                protocol = "tcp"
            }
        ]
    }
}


module "sg_public" {
    source = "git::https://github.com/kumargaurav522/sg.git"
    vpc_cidr = local.vpc_cidr
    vpc_id = local.vpc_id
    ingress = local.nginx_service.ingress
    egress = local.nginx_service.egress
    name = "Public security group"
    description = "Public secuirty group"
}


module "sg_rds" {
    source = "git::https://github.com/kumargaurav522/sg.git"
    vpc_cidr = local.vpc_cidr
    vpc_id = local.vpc_id
    ingress = local.rds_cluster.ingress
    egress = local.rds_cluster.egress
    name = "RDS security group"
    description = "RDS secuirty group"
}

module "sg_internal" {
    source = "git::https://github.com/kumargaurav522/sg.git"
    vpc_cidr = local.vpc_cidr
    vpc_id = local.vpc_id
    ingress = local.internal.ingress
    egress = local.internal.egress
    name = "Private security group"
    description = "Private secuirty group"
}

```

We also need a variables.tf

```hcl
#####################################################
# Variables
#####################################################

variable "region" {
    type = string
    default = "eu-west-1"
    description = "(optional) describe your variable"
}


variable "vpc_cidr" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "public_subnets" {
    type = list
}
variable "private_subnets" {
    type = list
}
```


## Outputs
	| Name | Description |
	|------|-------------|
	| id | The ID of the security group|

## Outputs

| Name | Description |
|------|-------------|
| <a name="id"></a> [id](#output\_id) | The ID of the security group |






