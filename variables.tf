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


variable "tags" {
  type        = any
  description = "Mention the tags"
}

variable "ingress" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    description     = string
    security_groups = list(string)

  }))
  description = "List of ingress rules"
  default     = {}
}

variable "egress" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    description     = string
    security_groups = list(string)

  }))
  description = "List of egress rules"
  default     = {}
}

