variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the security group will be created"
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "List of allowed CIDR blocks"
}


# variable "allowed_ips" {
#   type = list(string)
# }

