variable "name" {}
variable "description" {}
variable "vpc_id" {}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the security group"
  type        = list(string)
}

# variable "allowed_ips" {
#   type = list(string)
# }

