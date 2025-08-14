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
