variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create security group"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "name" {
  type        = string
  description = "Name of Security group"
}

variable "description" {
  type        = string
  description = "Description of Security group"
}

variable "ingress" {
  type        = any
  description = "List of ingress rules"
}

variable "tags" {
  type        = any
  description = "Mention the tags"
}


variable "egress" {
  type        = any
  description = "List of egress rules"
}

variable "security_groups" {
  type        = list(string)
  description = "Add security groups id"
  default     = []
}

