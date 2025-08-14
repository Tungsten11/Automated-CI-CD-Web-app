variable "region" {
  default = "ap-southeast-1"
}

variable "grafana_password" {
  description = "Password for Grafana admin user"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC where resources will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the EC2 instance will be deployed"
  type        = string
}

variable "allowed_cidrs" {
  type    = list(string)
  default = ["${local.my_ip}/32"]
}
