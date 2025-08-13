variable "region" {
  default = "ap-southeast-1"
}

variable "grafana_password" {
  description = "Grafana admin password"
  type        = string
  sensitive   = true
}
