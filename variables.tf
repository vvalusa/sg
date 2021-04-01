variable "vpc_id" {
    type = string
    description = "vpc_id"
}

variable "vpc_cidr" {
    type = string
    description = "vpc_cidr"
}

variable "name" {
    type = string
    description = "Name of Security group"
}

variable "description" {
    type = string
    description = "Description of Security group"
}

variable "ingress" {
    type = any
    description = "Ingress block"
}


variable "egress" {
    type = any
    description = "Egress block"
}

